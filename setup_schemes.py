#!/usr/bin/env python3
"""
Automated Xcode Scheme Setup Script
Creates multiple schemes (Dev, Staging, Production) for CityServe project
"""

import re
import os
import uuid
import shutil
from pathlib import Path

# Project paths
PROJECT_ROOT = Path(__file__).parent
XCODEPROJ = PROJECT_ROOT / "CityServe.xcodeproj"
PBXPROJ = XCODEPROJ / "project.pbxproj"
SCHEMES_DIR = XCODEPROJ / "xcshareddata" / "xcschemes"

# Configuration file paths (relative to project root)
CONFIG_FILES = {
    "Debug-Dev": "CityServe/Config/Dev.xcconfig",
    "Debug-Staging": "CityServe/Config/Staging.xcconfig",
    "Debug-Production": "CityServe/Config/Production.xcconfig",
    "Release-Dev": "CityServe/Config/Dev.xcconfig",
    "Release-Staging": "CityServe/Config/Staging.xcconfig",
    "Release-Production": "CityServe/Config/Production.xcconfig",
}

def generate_uuid():
    """Generate a UUID in Xcode format (24 hex characters)"""
    return uuid.uuid4().hex[:24].upper()

def read_pbxproj():
    """Read the project.pbxproj file"""
    with open(PBXPROJ, 'r') as f:
        return f.read()

def write_pbxproj(content):
    """Write the project.pbxproj file"""
    with open(PBXPROJ, 'w') as f:
        f.write(content)

def find_existing_config_uuid(content, config_name):
    """Find UUID of existing configuration (Debug or Release)"""
    pattern = rf'([A-F0-9]{{24}}) /\* {re.escape(config_name)} \*/ = \{{'
    match = re.search(pattern, content)
    return match.group(1) if match else None

def find_xcconfig_file_ref(content, filename):
    """Find or create file reference for xcconfig file"""
    # Look for existing reference
    pattern = rf'([A-F0-9]{{24}}) /\* {re.escape(filename)} \*/ = {{isa = PBXFileReference'
    match = re.search(pattern, content)
    if match:
        return match.group(1)

    # Create new file reference UUID
    return generate_uuid()

def add_config_file_references(content):
    """Add xcconfig file references to the project"""
    file_refs = {}

    # Find the PBXFileReference section
    section_start = content.find("/* Begin PBXFileReference section */")
    section_end = content.find("/* End PBXFileReference section */")

    if section_start == -1:
        print("❌ Could not find PBXFileReference section")
        return content, file_refs

    # Check if config files already exist
    for config_file in ["Dev.xcconfig", "Staging.xcconfig", "Production.xcconfig"]:
        uuid_val = find_xcconfig_file_ref(content, config_file)
        file_refs[config_file] = uuid_val

        # Check if reference exists
        if f"{uuid_val} /* {config_file} */" not in content:
            # Add new file reference
            new_ref = f'\t\t{uuid_val} /* {config_file} */ = {{isa = PBXFileReference; lastKnownFileType = text.xcconfig; path = {config_file}; sourceTree = "<group>"; }};\n'
            content = content[:section_end] + new_ref + content[section_end:]
            print(f"✅ Added file reference for {config_file}")

    return content, file_refs

def add_build_configurations(content, file_refs):
    """Add build configurations to the project"""
    # Find the XCConfigurationList section
    config_list_pattern = r'([A-F0-9]{24}) /\* Build configuration list for PBXProject "CityServe" \*/ = {[^}]+buildConfigurations = \([^)]+\);'
    config_list_match = re.search(config_list_pattern, content, re.DOTALL)

    if not config_list_match:
        print("❌ Could not find build configuration list")
        return content

    # Find existing Debug and Release UUIDs
    debug_uuid = find_existing_config_uuid(content, "Debug")
    release_uuid = find_existing_config_uuid(content, "Release")

    if not debug_uuid or not release_uuid:
        print("❌ Could not find existing Debug/Release configurations")
        return content

    print(f"Found Debug UUID: {debug_uuid}")
    print(f"Found Release UUID: {release_uuid}")

    # Read the Debug configuration as template
    debug_pattern = rf'{debug_uuid} /\* Debug \*/ = {{(?:[^{{}}]|{{[^{{}}]*}})*}};'
    debug_match = re.search(debug_pattern, content, re.DOTALL)

    if not debug_match:
        print("❌ Could not find Debug configuration content")
        return content

    debug_content = debug_match.group(0)

    # Read the Release configuration as template
    release_pattern = rf'{release_uuid} /\* Release \*/ = {{(?:[^{{}}]|{{[^{{}}]*}})*}};'
    release_match = re.search(release_pattern, content, re.DOTALL)

    if not release_match:
        print("❌ Could not find Release configuration content")
        return content

    release_content = release_match.group(0)

    # Create new configurations
    new_configs = []
    config_uuids = {}

    for config_name, xcconfig_path in CONFIG_FILES.items():
        new_uuid = generate_uuid()
        config_uuids[config_name] = new_uuid

        # Determine which template to use
        if config_name.startswith("Debug"):
            template = debug_content
            base_name = "Debug"
        else:
            template = release_content
            base_name = "Release"

        # Get the xcconfig filename
        xcconfig_file = Path(xcconfig_path).name
        xcconfig_uuid = file_refs.get(xcconfig_file, "")

        # Create new configuration by modifying template
        new_config = template.replace(debug_uuid if base_name == "Debug" else release_uuid, new_uuid)
        new_config = new_config.replace(f'/* {base_name} */', f'/* {config_name} */')
        new_config = new_config.replace(f'name = {base_name};', f'name = {config_name};')

        # Add base configuration reference if xcconfig UUID exists
        if xcconfig_uuid and "baseConfigurationReference" not in new_config:
            # Insert before buildSettings
            new_config = new_config.replace(
                "buildSettings = {",
                f'baseConfigurationReference = {xcconfig_uuid} /* {xcconfig_file} */;\n\t\t\t\tbuildSettings = {{'
            )

        new_configs.append(new_config)
        print(f"✅ Created configuration: {config_name}")

    # Add new configurations after Release configuration
    insert_pos = content.find(release_content) + len(release_content)
    content = content[:insert_pos] + '\n' + '\n'.join(new_configs) + content[insert_pos:]

    # Update buildConfigurations array in XCConfigurationList
    config_list_section = config_list_match.group(0)
    buildConfigurations_pattern = r'buildConfigurations = \(([^)]+)\);'
    buildConfigs_match = re.search(buildConfigurations_pattern, config_list_section)

    if buildConfigs_match:
        existing_configs = buildConfigs_match.group(1)
        new_config_refs = '\n'.join([f'\t\t\t\t{uuid} /* {name} */,' for name, uuid in config_uuids.items()])
        updated_configs = existing_configs.rstrip(',\n\t ') + ',\n' + new_config_refs
        new_config_list = config_list_section.replace(
            f'buildConfigurations = ({existing_configs});',
            f'buildConfigurations = ({updated_configs}\n\t\t\t);'
        )
        content = content.replace(config_list_section, new_config_list)
        print("✅ Updated build configurations list")

    return content

def create_scheme_file(scheme_name, config_debug, config_release):
    """Create a .xcscheme file"""
    scheme_content = f'''<?xml version="1.0" encoding="UTF-8"?>
<Scheme
   LastUpgradeVersion = "1500"
   version = "1.7">
   <BuildAction
      parallelizeBuildables = "YES"
      buildImplicitDependencies = "YES">
      <BuildActionEntries>
         <BuildActionEntry
            buildForTesting = "YES"
            buildForRunning = "YES"
            buildForProfiling = "YES"
            buildForArchiving = "YES"
            buildForAnalyzing = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "4DDFC73E2C80C03E00F97B3A"
               BuildableName = "CityServe.app"
               BlueprintName = "CityServe"
               ReferencedContainer = "container:CityServe.xcodeproj">
            </BuildableReference>
         </BuildActionEntry>
      </BuildActionEntries>
   </BuildAction>
   <TestAction
      buildConfiguration = "{config_debug}"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      shouldUseLaunchSchemeArgsEnv = "YES"
      shouldAutocreateTestPlan = "YES">
   </TestAction>
   <LaunchAction
      buildConfiguration = "{config_debug}"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      launchStyle = "0"
      useCustomWorkingDirectory = "NO"
      ignoresPersistentStateOnLaunch = "NO"
      debugDocumentVersioning = "YES"
      debugServiceExtension = "internal"
      allowLocationSimulation = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "4DDFC73E2C80C03E00F97B3A"
            BuildableName = "CityServe.app"
            BlueprintName = "CityServe"
            ReferencedContainer = "container:CityServe.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </LaunchAction>
   <ProfileAction
      buildConfiguration = "{config_release}"
      shouldUseLaunchSchemeArgsEnv = "YES"
      savedToolIdentifier = ""
      useCustomWorkingDirectory = "NO"
      debugDocumentVersioning = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "4DDFC73E2C80C03E00F97B3A"
            BuildableName = "CityServe.app"
            BlueprintName = "CityServe"
            ReferencedContainer = "container:CityServe.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </ProfileAction>
   <AnalyzeAction
      buildConfiguration = "{config_debug}">
   </AnalyzeAction>
   <ArchiveAction
      buildConfiguration = "{config_release}"
      revealArchiveInOrganizer = "YES">
   </ArchiveAction>
</Scheme>
'''
    return scheme_content

def create_schemes():
    """Create scheme files"""
    # Create schemes directory if it doesn't exist
    SCHEMES_DIR.mkdir(parents=True, exist_ok=True)

    schemes = [
        ("CityServe-Dev", "Debug-Dev", "Release-Dev"),
        ("CityServe-Staging", "Debug-Staging", "Release-Staging"),
        ("CityServe-Production", "Debug-Production", "Release-Production"),
    ]

    for scheme_name, debug_config, release_config in schemes:
        scheme_file = SCHEMES_DIR / f"{scheme_name}.xcscheme"
        scheme_content = create_scheme_file(scheme_name, debug_config, release_config)

        with open(scheme_file, 'w') as f:
            f.write(scheme_content)

        print(f"✅ Created scheme: {scheme_name}")

def main():
    print("🚀 Starting automated Xcode scheme setup...\n")

    # Step 1: Read project file
    print("📖 Reading project.pbxproj...")
    content = read_pbxproj()

    # Step 2: Add xcconfig file references
    print("\n📁 Adding xcconfig file references...")
    content, file_refs = add_config_file_references(content)

    # Step 3: Add build configurations
    print("\n⚙️  Adding build configurations...")
    content = add_build_configurations(content, file_refs)

    # Step 4: Write updated project file
    print("\n💾 Writing updated project.pbxproj...")
    write_pbxproj(content)

    # Step 5: Create scheme files
    print("\n📋 Creating scheme files...")
    create_schemes()

    print("\n✅ Setup complete!")
    print("\nNext steps:")
    print("1. Close and reopen Xcode")
    print("2. You should see 3 new schemes: CityServe-Dev, CityServe-Staging, CityServe-Production")
    print("3. Add Firebase config files to CityServe/Firebase/ directory")
    print("4. Select a scheme and build!")

if __name__ == "__main__":
    main()

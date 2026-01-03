#!/usr/bin/env python3
"""
Add Firebase Config Copy Build Phase to Xcode Project
"""

import re
import uuid
from pathlib import Path

# Project paths
PROJECT_ROOT = Path(__file__).parent
PBXPROJ = PROJECT_ROOT / "CityServe.xcodeproj" / "project.pbxproj"

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

def add_build_phase(content):
    """Add the Firebase config copy build phase"""

    # Check if build phase already exists
    if "Copy Firebase Config" in content:
        print("⚠️  Build phase already exists, skipping...")
        return content

    # Generate UUID for the build phase
    build_phase_uuid = generate_uuid()

    # Create the build phase entry
    build_phase_entry = f'''		{build_phase_uuid} /* ShellScript */ = {{
			isa = PBXShellScriptBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			inputFileListPaths = (
			);
			inputPaths = (
			);
			outputFileListPaths = (
			);
			outputPaths = (
			);
			runOnlyForDeploymentPostprocessing = 0;
			shellPath = /bin/bash;
			shellScript = "bash \\"${{SRCROOT}}/CityServe/Scripts/copy-firebase-config.sh\\"\\n";
			showEnvVarsInLog = 0;
			name = "Copy Firebase Config";
		}};
'''

    # Find PBXShellScriptBuildPhase section
    section_marker = "/* Begin PBXShellScriptBuildPhase section */"
    section_end_marker = "/* End PBXShellScriptBuildPhase section */"

    section_start = content.find(section_marker)

    if section_start == -1:
        # Section doesn't exist, create it
        # Find a good place to insert (after PBXResourcesBuildPhase)
        resources_section_end = content.find("/* End PBXResourcesBuildPhase section */")
        if resources_section_end != -1:
            insert_pos = content.find("\n", resources_section_end) + 1
            new_section = f"\n/* Begin PBXShellScriptBuildPhase section */\n{build_phase_entry}/* End PBXShellScriptBuildPhase section */\n"
            content = content[:insert_pos] + new_section + content[insert_pos:]
            print("✅ Created PBXShellScriptBuildPhase section")
        else:
            print("❌ Could not find location to insert build phase section")
            return content
    else:
        # Section exists, add our build phase to it
        section_end = content.find(section_end_marker)
        content = content[:section_end] + build_phase_entry + content[section_end:]
        print("✅ Added build phase to existing section")

    # Now add the build phase to the target's buildPhases array
    # Find the CityServe target
    target_pattern = r'([A-F0-9]{24}) /\* CityServe \*/ = {[^}]+isa = PBXNativeTarget;[^}]+buildPhases = \(([^)]+)\);'
    target_match = re.search(target_pattern, content, re.DOTALL)

    if not target_match:
        print("❌ Could not find CityServe target")
        return content

    target_uuid = target_match.group(1)
    current_build_phases = target_match.group(2)

    # Add our build phase UUID to the buildPhases array
    # We want to add it before "Copy Bundle Resources" if possible
    resources_phase_pattern = r'([A-F0-9]{24}) /\* Resources \*/,'
    resources_match = re.search(resources_phase_pattern, current_build_phases)

    if resources_match:
        # Insert before Resources phase
        resources_line = resources_match.group(0)
        new_phase_line = f'\n\t\t\t\t{build_phase_uuid} /* ShellScript */,'
        updated_build_phases = current_build_phases.replace(resources_line, new_phase_line + '\n\t\t\t\t' + resources_line)
    else:
        # Just add at the end
        updated_build_phases = current_build_phases.rstrip(',\n\t ') + f',\n\t\t\t\t{build_phase_uuid} /* ShellScript */,'

    # Replace the buildPhases array
    content = content.replace(
        f'buildPhases = ({current_build_phases});',
        f'buildPhases = ({updated_build_phases}\n\t\t\t);'
    )

    print("✅ Added build phase to CityServe target")

    return content

def main():
    print("🔧 Adding Firebase Config copy build phase...\n")

    # Read project file
    print("📖 Reading project.pbxproj...")
    content = read_pbxproj()

    # Add build phase
    print("\n⚙️  Adding build phase...")
    content = add_build_phase(content)

    # Write updated project file
    print("\n💾 Writing updated project.pbxproj...")
    write_pbxproj(content)

    print("\n✅ Build phase added successfully!")

if __name__ == "__main__":
    main()

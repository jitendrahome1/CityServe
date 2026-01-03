#!/usr/bin/env python3
"""
Fix build configuration issues
"""

import re
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent
PBXPROJ = PROJECT_ROOT / "CityServe.xcodeproj" / "project.pbxproj"

def fix_xcconfig_paths(content):
    """Fix the paths to xcconfig files to include Config/ directory"""

    # Fix file references to include Config/ path
    content = re.sub(
        r'(isa = PBXFileReference; lastKnownFileType = text\.xcconfig; path = )(Dev\.xcconfig)',
        r'\1Config/\2; name = \2',
        content
    )
    content = re.sub(
        r'(isa = PBXFileReference; lastKnownFileType = text\.xcconfig; path = )(Staging\.xcconfig)',
        r'\1Config/\2; name = \2',
        content
    )
    content = re.sub(
        r'(isa = PBXFileReference; lastKnownFileType = text\.xcconfig; path = )(Production\.xcconfig)',
        r'\1Config/\2; name = \2',
        content
    )

    print("✅ Fixed xcconfig file paths")
    return content

def main():
    print("🔧 Fixing build configuration issues...\n")

    # Read project file
    print("📖 Reading project.pbxproj...")
    with open(PBXPROJ, 'r') as f:
        content = f.read()

    # Fix xcconfig paths
    print("\n⚙️  Fixing xcconfig paths...")
    content = fix_xcconfig_paths(content)

    # Write updated project file
    print("\n💾 Writing updated project.pbxproj...")
    with open(PBXPROJ, 'w') as f:
        f.write(content)

    print("\n✅ Build issues fixed!")

if __name__ == "__main__":
    main()

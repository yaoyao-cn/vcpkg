import os
import subprocess
import re
import shutil
import argparse

g_curDir = os.path.dirname(os.path.realpath(__file__))
g_export_reg = '^vcpkg-export-[0-9]{8}-[0-9]{6}$'

def GetTriplets(pkgs):
    s = []
    for name in pkgs:
        #s.append("%s:x86-windows"%(name))
        s.append("%s:x64-windows"%(name))
    return s

def DeleteOldExports():
    print('Find and delete old exports from vkpkg...')
    for dirName in (os.listdir(os.path.join(g_curDir, '..\\'))):
        if re.match(g_export_reg, dirName):
            print('deleting %s'%dirName)
            fullName = os.path.join(g_curDir, '..\\', dirName)
            if os.path.isdir(fullName):
                shutil.rmtree(fullName)

def DoExport(pkgs, extraArgs):
    print('Export packages using vcpkg...')
    vcpkg_exe = os.path.join(g_curDir, '..\\vcpkg.exe')
    args = [vcpkg_exe, 'export']
    args.extend(GetTriplets(pkgs))
    args.extend(extraArgs)
    subprocess.run(args)

def CleanupExport():
    #delete pdbs
    print('Delete pdbs...')
    for dirName in (os.listdir(os.path.join(g_curDir, '..\\'))):
        if re.match(g_export_reg, dirName):
            for root, dirs, files in os.walk(os.path.join(g_curDir, '..\\', dirName)):
                for name in files:
                    if os.path.splitext(name)[-1] == '.pdb':
                        print('delete ' + os.path.join(root, name))
                        os.remove(os.path.join(root, name))

def PatchExports():
    print('Patching exports...')
    for dirName in (os.listdir(os.path.join(g_curDir, '..\\'))):
        if re.match(g_export_reg, dirName):
            print('patching %s'%dirName)
            shutil.copy(os.path.join(g_curDir, '..\\', 'vcpkg.exe'), os.path.join(g_curDir, '..\\', dirName, 'vcpkg.exe'))
            shutil.copy(os.path.join(g_curDir, 'readme.md'), os.path.join(g_curDir, '..\\', dirName, 'readme.md'))
            shutil.copytree(os.path.join(g_curDir, '..\\', 'triplets'), os.path.join(g_curDir, '..\\', dirName, 'triplets'))
            shutil.copy(os.path.join(g_curDir, '..\\', 'scripts\\ports.cmake'), os.path.join(g_curDir, '..\\', dirName, 'scripts\\ports.cmake'))

def ZipExports():
    print('Compress exported packages to zip archive...')
    for dirName in (os.listdir(os.path.join(g_curDir, '..\\'))):
        if re.match(g_export_reg, dirName):
            print('compress %s'%dirName)
            shutil.make_archive(
                os.path.join(g_curDir, '..\\', dirName), 'zip',
                os.path.join(g_curDir, '..\\'), dirName)
            zipSize = os.path.getsize(os.path.join(g_curDir, '..\\', dirName) + '.zip')
            print('zip archive size %.2fM'%(zipSize/1024/1024))

def MakePkg(pkgs):
    DeleteOldExports()
    DoExport(pkgs, ['--raw'])
    CleanupExport()
    PatchExports()
    ZipExports()

def Install(pkgs):
    print('Install packages using vcpkg...')
    vcpkg_exe = os.path.join(g_curDir, '..\\vcpkg.exe')
    args = [vcpkg_exe, 'install']
    args.extend(GetTriplets(pkgs))
    subprocess.run(args)

allPkgs = (
    '7zip',
    'berkeleydb',
    'curl', 'cxxopts',
    'directxtex','duktape',
    'eigen3',
    'fcl', 'ffmpeg', 'freeimage',
    'glog', 'geos',
    'jsoncpp',
    'libgeotiff', 'libjpeg-turbo', 'libsndfile',
    'md5', 'mongoose',
    'openal-soft', 'openvr',
    'poly2tri', 'portaudio', 'pugixml',
    'sqlite3','sqlitecpp',
    'tinyxml',
    'vcglib',
    'zlib',
)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Install or export vkpkg packages.')
    parser.add_argument('-i', '--install', action='store_true', help='install packages')
    parser.add_argument('-e', '--export', action='store_true', help='export packages')

    args = parser.parse_args()

    if args.export:
        MakePkg(allPkgs)
    elif args.install:
        Install(allPkgs)
    else:
        parser.print_help()
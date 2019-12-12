import os
import subprocess
import re
import shutil

g_curDir = os.path.dirname(os.path.realpath(__file__))

def GetTriplets(pkgs):
    s = []
    for name in pkgs:
        s.append("%s:x86-windows"%(name))
        s.append("%s:x64-windows"%(name))
    return s

def DeleteOldExports():
    print('Find and delete old exports from vkpkg...')
    for dirName in (os.listdir(os.path.join(g_curDir, '..\\'))):
        if re.match('^vcpkg-export-.*', dirName):
            print('deleting %s'%dirName)
            fullName = os.path.join(g_curDir, '..\\', dirName)
            if os.path.isdir(fullName):
                shutil.rmtree(fullName)
            elif os.path.isfile(fullName):
                os.remove(fullName)

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
        if re.match('^vcpkg-export-.*', dirName):
            for root, dirs, files in os.walk(os.path.join(g_curDir, '..\\', dirName)):
                for name in files:
                    if os.path.splitext(name)[-1] == '.pdb':
                        print('delete ' + os.path.join(root, name))
                        os.remove(os.path.join(root, name))

def PatchExports():
    print('Patching exports...')
    for dirName in (os.listdir(os.path.join(g_curDir, '..\\'))):
        if re.match('^vcpkg-export-.*', dirName):
            print('patching %s'%dirName)
            shutil.copy(os.path.join(g_curDir, '..\\', 'vcpkg.exe'), os.path.join(g_curDir, '..\\', dirName, 'vcpkg.exe'))
            shutil.copy(os.path.join(g_curDir, 'readme.md'), os.path.join(g_curDir, '..\\', dirName, 'readme.md'))

def ZipExports():
    print('Compress exported packages to zip archive...')
    for dirName in (os.listdir(os.path.join(g_curDir, '..\\'))):
        if re.match('^vcpkg-export-.*', dirName):
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


allPkgs = (
    '7zip',
    'berkeleydb',
    'cppcodec', 'curl', 'cxxopts',
    'directxtex',
    'eigen3',
    'ffmpeg', 'freeimage',
    'glog',
    'jsoncpp',
    'libjpeg-turbo', 'lmdb',
    'md5', 'mongoose',
    'openal-soft', 'openvr',
    'poly2tri', 'portaudio',
    'sqlite3','sqlitecpp',
    'tinyxml',
    'vcglib',
    'zlib',
)

if __name__ == '__main__':
    MakePkg(allPkgs)
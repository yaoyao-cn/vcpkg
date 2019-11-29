import os
import subprocess

def GetTriplets(pkgs):
    s = []
    for name in pkgs:
        s.append("%s:x86-windows"%(name))
        s.append("%s:x64-windows"%(name))
    return s

def DoExport(pkgs, extraArgs):
    path = os.path.dirname(os.path.realpath(__file__))
    vcpkg_exe = os.path.join(path, '..\\vcpkg.exe')
    args = [vcpkg_exe, 'export']
    args.extend(GetTriplets(pkgs))
    args.extend(extraArgs)
    subprocess.call(args)

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
    'sqlite3',
    'tinyxml',
    'vcglib',
    'zlib',
)

DoExport(['poly2tri', 'sqlite3'], ['--raw'])


const allPkgs = `
cxxopts
freeglut
freeimage
giflib
jasper
jsoncpp
jxrlib
lcms
libjpeg-turbo
liblzma
libpng
libraw
libwebp
libwebp[all]
openexr
opengl
openjpeg
sdl1
sqlite3
tiff
tinyxml2
zlib
`;

function GenScript(pkgs){
    let s = './vcpkg.exe export';

    for(const name of pkgs){
        s += ` ${name}:x86-windows ${name}:x64-windows`
    }

    s += ' --nuget';

    return s;
}

console.log(GenScript([
    'cxxopts',
    'freeimage',
    'jsoncpp',
    'sqlite3',
    'liblzma',
    'tinyxml2'
]));

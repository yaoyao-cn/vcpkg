function GetTriplets(pkgs){
    let s = '';
    for(const name of pkgs){
        s += `${name}:x86-windows ${name}:x64-windows `
    }
    return s;
}

function GetExportScript(pkgs, type = '--raw'){
    return `./vcpkg.exe export ${GetTriplets(pkgs)} ${type}`;
}

function GetInstallScript(pkgs){
    return `./vcpkg.exe install ${GetTriplets(pkgs)}`;
}

const allPkgs = [
    'cxxopts',
    'freeimage',
    'jsoncpp',
    'sqlite3',
    'liblzma',
    'tinyxml2',
    'curl',
    'openvr'
];

console.log(GetInstallScript(allPkgs));
console.log(GetExportScript(allPkgs));

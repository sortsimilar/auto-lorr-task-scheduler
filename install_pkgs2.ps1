$bash = "C:\msys64\msys64\usr\bin\bash.exe"
$pkgdir = "C:\msys64\msys64\pkg_temp"
$root = "C:\msys64\msys64"

$packages = @(
    "mingw-w64-x86_64-gcc-libs-15.2.0-14-any.pkg.tar.zst",
    "mingw-w64-x86_64-winpthreads-13.0.0.r179.g8181947cc-1-any.pkg.tar.zst",
    "mingw-w64-x86_64-gcc-15.2.0-14-any.pkg.tar.zst",
    "mingw-w64-x86_64-make-4.4.1-4-any.pkg.tar.zst",
    "mingw-w64-x86_64-cmake-4.3.2-2-any.pkg.tar.zst",
    "mingw-w64-x86_64-boost-1.90.0-3-any.pkg.tar.zst"
)

foreach ($pkg in $packages) {
    $path = Join-Path $pkgdir $pkg
    Write-Host "Extracting $pkg to $root..."
    & $bash -c "cd '$root' && tar --zstd -xf '$path' 2>&1"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  FAILED with exit code $LASTEXITCODE"
    } else {
        Write-Host "  OK"
    }
}

Write-Host "Checking files..."
& $bash -c "test -f '$root/mingw64/bin/gcc.exe' && echo 'gcc: FOUND' || echo 'gcc: NOT FOUND'"
& $bash -c "test -f '$root/mingw64/bin/make.exe' && echo 'make: FOUND' || echo 'make: NOT FOUND'"
& $bash -c "test -f '$root/mingw64/bin/cmake.exe' && echo 'cmake: FOUND' || echo 'cmake: NOT FOUND'"

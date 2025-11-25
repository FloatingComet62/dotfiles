{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    gdb
    gnumake
    cmake
    clang-tools
    pkg-config
    llvmPackages_21.clang-unwrapped
    llvmPackages_21.bintools-unwrapped
    llvmPackages_21.llvm.out
    llvmPackages_21.llvm.dev
    llvmPackages_21.compiler-rt
    llvmPackages_21.libunwind
    llvmPackages_21.openmp
  ];
}

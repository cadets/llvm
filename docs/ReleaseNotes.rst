========================
LLVM 7.0.0 Release Notes
========================

.. contents::
    :local:

.. warning::
   These are in-progress notes for the upcoming LLVM 7 release.
   Release notes for previous releases can be found on
   `the Download Page <http://releases.llvm.org/download.html>`_.


Introduction
============

This document contains the release notes for the LLVM Compiler Infrastructure,
release 7.0.0.  Here we describe the status of LLVM, including major improvements
from the previous release, improvements in various subprojects of LLVM, and
some of the current users of the code.  All LLVM releases may be downloaded
from the `LLVM releases web site <http://llvm.org/releases/>`_.

For more information about LLVM, including information about the latest
release, please check out the `main LLVM web site <http://llvm.org/>`_.  If you
have questions or comments, the `LLVM Developer's Mailing List
<http://lists.llvm.org/mailman/listinfo/llvm-dev>`_ is a good place to send
them.

Note that if you are reading this file from a Subversion checkout or the main
LLVM web page, this document applies to the *next* release, not the current
one.  To see the release notes for a specific release, please see the `releases
page <http://llvm.org/releases/>`_.

Non-comprehensive list of changes in this release
=================================================
.. NOTE
   For small 1-3 sentence descriptions, just add an entry at the end of
   this list. If your description won't fit comfortably in one bullet
   point (e.g. maybe you would like to give an example of the
   functionality, or simply have a lot to talk about), see the `NOTE` below
   for adding a new subsection.

* The Windows installer no longer includes a Visual Studio integration.
  Instead, a new
  `LLVM Compiler Toolchain Visual Studio extension <https://marketplace.visualstudio.com/items?itemName=LLVMExtensions.llvm-toolchain>`
  is available on the Visual Studio Marketplace. The new integration includes
  support for Visual Studio 2017.

* Libraries have been renamed from 7.0 to 7. This change also impacts
  downstream libraries like lldb.

* The LoopInstSimplify pass (-loop-instsimplify) has been removed.

* Symbols starting with ``?`` are no longer mangled by LLVM when using the
  Windows ``x`` or ``w`` IR mangling schemes.

* A new tool named :doc:`llvm-exegesis <CommandGuide/llvm-exegesis>` has been
  added. :program:`llvm-exegesis` automatically measures instruction scheduling
  properties (latency/uops) and provides a principled way to edit scheduling
  models.

* A new tool named :doc:`llvm-mca <CommandGuide/llvm-mca>` has been added.
  :program:`llvm-mca` is a  static performance analysis tool that uses
  information available in LLVM to statically predict the performance of
  machine code for a specific CPU.

* The optimization flag to merge constants (-fmerge-all-constants) is no longer
  applied by default.

* Optimization of floating-point casts is improved. This may cause surprising
  results for code that is relying on the undefined behavior of overflowing 
  casts. The optimization can be disabled by specifying a function attribute:
  "strict-float-cast-overflow"="false". This attribute may be created by the
  clang option ``-fno-strict-float-cast-overflow``.
  Code sanitizers can be used to detect affected patterns. The option for
  detecting this problem alone is "-fsanitize=float-cast-overflow":

.. code-block:: c

    int main() {
      float x = 4294967296.0f;
      x = (float)((int)x);
      printf("junk in the ftrunc: %f\n", x);
      return 0;
    }

.. code-block:: bash

    clang -O1 ftrunc.c -fsanitize=float-cast-overflow ; ./a.out 
    ftrunc.c:5:15: runtime error: 4.29497e+09 is outside the range of representable values of type 'int'
    junk in the ftrunc: 0.000000

* ``LLVM_ON_WIN32`` is no longer set by ``llvm/Config/config.h`` and
  ``llvm/Config/llvm-config.h``.  If you used this macro, use the compiler-set
  ``_WIN32`` instead which is set exactly when ``LLVM_ON_WIN32`` used to be set.

* The ``DEBUG`` macro has been renamed to ``LLVM_DEBUG``, the interface remains
  the same.  If you used this macro you need to migrate to the new one.
  You should also clang-format your code to make it easier to integrate future
  changes locally.  This can be done with the following bash commands:

.. code-block:: bash

    git grep -l 'DEBUG' | xargs perl -pi -e 's/\bDEBUG\s?\(/LLVM_DEBUG(/g'
    git diff -U0 master | ../clang/tools/clang-format/clang-format-diff.py -i -p1 -style LLVM

* Early support for UBsan, X-Ray instrumentation and libFuzzer (x86 and x86_64) for OpenBSD. Support for MSan
  (x86_64), X-Ray instrumentation and libFuzzer (x86 and x86_64) for FreeBSD.

* ``SmallVector<T, 0>`` shrank from ``sizeof(void*) * 4 + sizeof(T)`` to
  ``sizeof(void*) + sizeof(unsigned) * 2``, smaller than ``std::vector<T>`` on
  64-bit platforms.  The maximum capacity is now restricted to ``UINT32_MAX``.
  Since SmallVector doesn't have the exception-safety pessimizations some
  implementations saddle std::vector with and is better at using ``realloc``,
  it's now a better choice even on the heap (although when TinyPtrVector works,
  it's even smaller).

* Preliminary/experimental support for DWARF v5 debugging information,
  including the new .debug_names accelerator table. DWARF emitted at ``-O0``
  should be fully DWARF v5 compliant. Type units and split DWARF are known
  not to be compliant, and higher optimization levels will still emit some
  information in v4 format.

* Added support for the ``.rva`` assembler directive for COFF targets.

* The :program:`llvm-rc` tool (Windows Resource Compiler) has been improved
  a bit. There are still known missing features, but it is generally usable
  in many cases. (The tool still doesn't preprocess input files automatically,
  but it can now handle leftover C declarations in preprocessor output, if
  given output from a preprocessor run externally.)

* CodeView debug info can now be emitted MinGW configurations, if requested.

* Note..

.. NOTE
   If you would like to document a larger change, then you can add a
   subsection about it right here. You can copy the following boilerplate
   and un-indent it (the indentation causes it to be inside this comment).

   Special New Feature
   -------------------

   Makes programs 10x faster by doing Special New Thing.

Changes to the LLVM IR
----------------------

* The signatures for the builtins @llvm.memcpy, @llvm.memmove, and @llvm.memset
  have changed. Alignment is no longer an argument, and are instead conveyed as
  parameter attributes.

* invariant.group.barrier has been renamed to launder.invariant.group.

* invariant.group metadata can now refer only empty metadata nodes.

Changes to the AArch64 Target
-----------------------------

* The ``.inst`` assembler directive is now usable on both COFF and Mach-O
  targets, in addition to ELF.

* Support for most remaining COFF relocations have been added.

* Support for TLS on Windows has been added.

Changes to the ARM Target
-------------------------

* The ``.inst`` assembler directive is now usable on both COFF and Mach-O
  targets, in addition to ELF. For Thumb, it can now also automatically
  deduce the instruction size, without having to specify it with
  e.g. ``.inst.w`` as before.

Changes to the Hexagon Target
-----------------------------

* Hexagon now supports auto-vectorization for HVX. It is disabled by default
  and can be turned on with ``-fvectorize``. For auto-vectorization to take
  effect, code generation for HVX needs to be enabled with ``-mhvx``.
  The complete set of options should include ``-fvectorize``, ``-mhvx``,
  and ``-mhvx-length={64b|128b}``.

* The support for Hexagon ISA V4 is deprecated and will be removed in the
  next release.

Changes to the MIPS Target
--------------------------

 During this release ...


Changes to the PowerPC Target
-----------------------------

 During this release ...

Changes to the SystemZ Target
-----------------------------

During this release the SystemZ target has:

* Added support for vector registers in inline asm statements.

* Added support for stackmaps, patchpoints, and the anyregcc
  calling convention.

* Changed the default function alignment to 16 bytes.

* Improved codegen for condition code handling.

* Improved instruction scheduling and microarchitecture tuning for z13/z14.

* Fixed support for generating GCOV coverage data.

* Fixed some codegen bugs.

Changes to the X86 Target
-------------------------

* The calling convention for the ``f80`` data type on MinGW targets has been
  fixed. Normally, the calling convention for this type is handled within clang,
  but if an intrinsic is used, which LLVM expands into a libcall, the
  proper calling convention needs to be supported in LLVM as well. (Note,
  on Windows, this data type is only used for long doubles in MinGW
  environments - in MSVC environments, long doubles are the same size as
  normal doubles.)

Changes to the AMDGPU Target
-----------------------------

 During this release ...

Changes to the AVR Target
-----------------------------

 During this release ...

Changes to the OCaml bindings
-----------------------------

* Remove ``add_bb_vectorize``.


Changes to the C API
--------------------

* Remove ``LLVMAddBBVectorizePass``. The implementation was removed and the C
  interface was made a deprecated no-op in LLVM 5. Use
  ``LLVMAddSLPVectorizePass`` instead to get the supported SLP vectorizer.

Changes to the DAG infrastructure
---------------------------------
* ADDC/ADDE/SUBC/SUBE are now deprecated and will default to expand. Backends
  that wish to continue to use these opcodes should explicitely request so
  using ``setOperationAction`` in their ``TargetLowering``. New backends
  should use UADDO/ADDCARRY/USUBO/SUBCARRY instead of the deprecated opcodes.

* The SETCCE opcode has now been removed in favor of SETCCCARRY.

* TableGen now supports multi-alternative pattern fragments via the PatFrags
  class.  PatFrag is now derived from PatFrags, which may require minor
  changes to backends that directly access PatFrag members.

External Open Source Projects Using LLVM 7
==========================================

* A project...


Additional Information
======================

A wide variety of additional information is available on the `LLVM web page
<http://llvm.org/>`_, in particular in the `documentation
<http://llvm.org/docs/>`_ section.  The web page also contains versions of the
API documentation which is up-to-date with the Subversion version of the source
code.  You can access versions of these documents specific to this release by
going into the ``llvm/docs/`` directory in the LLVM tree.

If you have any questions or comments about LLVM, please feel free to contact
us via the `mailing lists <http://llvm.org/docs/#maillist>`_.

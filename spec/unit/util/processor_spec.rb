#! /usr/bin/env ruby

require 'spec_helper'
require 'facter/util/processor'

def cpuinfo_fixture(filename)
  File.open(fixtures('cpuinfo', filename)).readlines
end

describe Facter::Util::Processor do
  it "should get the processor description from the amd64solo fixture" do
    Facter.fact(:kernel).stubs(:value).returns("Linux")
    Facter.fact(:architecture).stubs(:value).returns("amd64")
    File.stubs(:exists?).with("/proc/cpuinfo").returns(true)
    File.stubs(:readlines).with("/proc/cpuinfo").returns(cpuinfo_fixture("amd64solo"))

    Facter::Util::Processor.enum_cpuinfo[0].should == "Intel(R) Core(TM)2 Duo CPU     P8700  @ 2.53GHz"
  end

  it "should get the processor descriptions from the amd64dual fixture" do
    Facter.fact(:kernel).stubs(:value).returns("Linux")
    Facter.fact(:architecture).stubs(:value).returns("amd64")
    File.stubs(:exists?).with("/proc/cpuinfo").returns(true)
    File.stubs(:readlines).with("/proc/cpuinfo").returns(cpuinfo_fixture("amd64dual"))

    Facter::Util::Processor.enum_cpuinfo[0].should == "Intel(R) Core(TM)2 Duo CPU     P8700  @ 2.53GHz"
    Facter::Util::Processor.enum_cpuinfo[1].should == "Intel(R) Core(TM)2 Duo CPU     P8700  @ 2.53GHz"
  end

  it "should get the processor descriptions from the amd64tri fixture" do
    Facter.fact(:kernel).stubs(:value).returns("Linux")
    Facter.fact(:architecture).stubs(:value).returns("amd64")
    File.stubs(:exists?).with("/proc/cpuinfo").returns(true)
    File.stubs(:readlines).with("/proc/cpuinfo").returns(cpuinfo_fixture("amd64tri"))

    Facter::Util::Processor.enum_cpuinfo[0].should == "Intel(R) Core(TM)2 Duo CPU     P8700  @ 2.53GHz"
    Facter::Util::Processor.enum_cpuinfo[1].should == "Intel(R) Core(TM)2 Duo CPU     P8700  @ 2.53GHz"
    Facter::Util::Processor.enum_cpuinfo[2].should == "Intel(R) Core(TM)2 Duo CPU     P8700  @ 2.53GHz"
  end

  it "should get the processor descriptions from the amd64quad fixture" do
    Facter.fact(:kernel).stubs(:value).returns("Linux")
    Facter.fact(:architecture).stubs(:value).returns("amd64")
    File.stubs(:exists?).with("/proc/cpuinfo").returns(true)
    File.stubs(:readlines).with("/proc/cpuinfo").returns(cpuinfo_fixture("amd64quad"))

    Facter::Util::Processor.enum_cpuinfo[0].should == "Quad-Core AMD Opteron(tm) Processor 2374 HE"
    Facter::Util::Processor.enum_cpuinfo[1].should == "Quad-Core AMD Opteron(tm) Processor 2374 HE"
    Facter::Util::Processor.enum_cpuinfo[2].should == "Quad-Core AMD Opteron(tm) Processor 2374 HE"
    Facter::Util::Processor.enum_cpuinfo[3].should == "Quad-Core AMD Opteron(tm) Processor 2374 HE"
  end

  it "should get the processor description on Solaris (x86)" do
    Facter.fact(:kernel).stubs(:value).returns("SunOS")
    Facter.fact(:architecture).stubs(:value).returns("i86pc")
    Facter::Util::Resolution.stubs(:exec).with("/usr/bin/kstat cpu_info").returns(my_fixture_read("solaris-i86pc"))

    Facter::Util::Processor.enum_kstat[0].should == "Intel(r) Core(tm) i5 CPU       M 450  @ 2.40GHz"
  end

  it "should get the processor description on Solaris (SPARC64)" do
    Facter.fact(:kernel).stubs(:value).returns("SunOS")
    Facter.fact(:architecture).stubs(:value).returns("sun4u")
    Facter::Util::Resolution.stubs(:exec).with("/usr/bin/kstat cpu_info").returns(my_fixture_read("solaris-sun4u"))

    Facter::Util::Processor.enum_kstat[0].should == "SPARC64-VII"
    Facter::Util::Processor.enum_kstat[1].should == "SPARC64-VII"
    Facter::Util::Processor.enum_kstat[2].should == "SPARC64-VII"
    Facter::Util::Processor.enum_kstat[3].should == "SPARC64-VII"
    Facter::Util::Processor.enum_kstat[4].should == "SPARC64-VII"
    Facter::Util::Processor.enum_kstat[5].should == "SPARC64-VII"
    Facter::Util::Processor.enum_kstat[6].should == "SPARC64-VII"
    Facter::Util::Processor.enum_kstat[7].should == "SPARC64-VII"
  end
end

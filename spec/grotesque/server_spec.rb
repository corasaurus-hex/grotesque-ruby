describe Grotesque::Server do
  let(:server) { Grotesque::Server.new(:zk_chroot => "grotesque_test") }
  let(:zk) { server.zk }

  before do
    server.flushall
  end

  context "when setting values" do
    it "should set a value for a given key" do
      server.set("foo", "bar")
      zk.get("/foo")[0].should == "bar"
    end

    it "should overwrite a value for a given key" do
      server.set("foo", "bar")
      server.set("foo", "baz")
      zk.get("/foo")[0].should == "baz"
    end

    it "should return true" do
      server.set("foo", "bar").should be_true
    end
  end

  context "when getting values" do
    it "should return nil when a value hasn't been set for the given key" do
      server.get("foo").should be_nil
    end

    it "should return a value when it has been set for the given key" do
      zk.create("/foo", "bar", :or => :set)
      server.get("foo").should == "bar"
    end
  end

  context "when deleting values" do
    it "should return zero when deleting a non-existant key" do
      server.del("foo").should == 0
    end

    it "should return 1 when deleting a key that exists" do
      zk.create("/foo", "bar", :or => :set)
      server.del("foo").should == 1
    end

    it "should return the number of keys that were deleted when" do
      zk.create("/foo", "bar", :or => :set)
      zk.create("/bar", "baz", :or => :set)
      zk.create("/bonk", "bing", :or => :set)
      server.del("foo", "bar", "blip", "bloop").should == 2
    end

    it "should delete the values" do
      zk.create("/foo", "bar", :or => :set)
      server.del("foo").should == 1
      expect{ zk.get("/foo") }.to raise_error(ZK::Exceptions::NoNode)
    end
  end

end

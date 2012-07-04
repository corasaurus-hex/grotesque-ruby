require "zk"
require "msgpack/rpc"

module Grotesque
  class Server

    attr_reader :zk

    def self.run(options)
      new(options).run
    end

    def initialize(options={})
      @options   = options.clone
      @port      = options.delete(:port)      || 9090
      @host      = options.delete(:host)      || "0.0.0.0"
      @zk_port   = options.delete(:zk_port)   || 2181
      @zk_host   = options.delete(:zk_host)   || "localhost"
      @zk_chroot = options.delete(:zk_chroot) || "grotesque"
      @zk        = ZK.new("#{@zk_host}:#{@zk_port}/#{@zk_chroot}")
    end

    def run
      server = MessagePack::RPC::Server.new
      server.listen(@host, @port, self, ["get", "set"])
      server.run
    end

    def get(key)
      key   = normalize_key(key)
      value = nil

      @zk.with_lock(key, :mode => :shared) do
        begin
          value, _ = @zk.get(key)
        rescue ZK::Exceptions::NoNode
        end
      end

      value
    end

    def set(key, value)
      key = normalize_key(key)

      @zk.with_lock(key, :mode => :exclusive) do
        @zk.create(key, value, :or => :set)
      end

      true
    end

    def del(*keys)
      deleted = 0

      keys.each do |key|
        key = normalize_key(key)

        @zk.with_lock(key, :mode => :exclusive) do
          begin
            @zk.delete(key)
            deleted += 1
          rescue ZK::Exceptions::NoNode
          end
        end
      end

      deleted
    end

    def flushall
      flushdb
    end

    def flushdb
      @zk.rm_rf("/")
      @zk.create("/")
      true
    end


  protected

    def normalize_key(key)
      raise ArgumentError, %{key "#{key.inspect}" must be a string} unless key.is_a?(String)
      raise ArgumentError, %{key "#{key.inspect}" contains an invalid character ("/")} if key.include?("/")

      "/#{key}"
    end

  end
end

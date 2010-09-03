class Hash
  # Return a new hash filtered to exclude any key-value pairs whose keys appear
  # in +keys+.
  def discard *keys
    dup.discard! *keys
  end

  # Filter this hash in-place so any key-value pairs whose keys appear in
  # +keys+ are removed.
  def discard! *keys
    keys.each {|k| delete k }
    self
  end

  # Return a new hash filtered to contain only the key-value pairs whose keys
  # appear in +keys+.
  def dragnet *keys
    dup.dragnet! *keys
  end

  # Filter this hash in-place so it contains only the key-value pairs whose
  # keys appear in +keys+.
  def dragnet! *keys
    keys.inject({}) {|acc,key|
      acc[key] = self.delete(key) if self.has_key?(key)
      acc
    }
  end

  # Reverse-merge +other+ into this hash in-place; that is, merge all
  # key-value pairs in +other+ whose keys are not already present in self.
  def defaults! other
    replace other.merge(self)
  end

  # Return a new hash consisting of +other+ reverse-merged into this hash;
  # that is, equal to +other.merge(self)+.
  def defaults other
    dup.defaults! other
  end

  # Return a new hash with the same keys as this hash, but with values
  # generated by yielding each key-value pair to +block+.
  def map_values &block
    dup.map_values! &block
  end

  # Update this hash in-place by replacing each value with the result of
  # yielding the corresponding key-value pair to the block.
  def map_values! &block
    keys.each {|k|
      self[k] = yield k, self[k]
    }
    self
  end

  # Return a new hash filtered to contain just the key-value pairs for which
  # the block returns true. That is, like Hash#select, but returning a hash
  # instead of an array of tuples.
  def selekt &block
    hsh = {}
    each_pair {|k,v|
      hsh[k] = v if yield(k,v)
    }
    hsh
  end

  # Return a new hash recursively filtered to remove all key-value pairs for
  # which the block returned true. That is, like Hash#reject, except sub-hashes
  # are also filtered.
  def reject_r &block
    dup.reject_r! &block
  end

  # Recursively filter this hash in-place to remove all key-value pairs for
  # which the block returned true. That is, like Hash#reject!, except
  # sub-hashes are also filtered.
  def reject_r! &block
    each_pair {|k,v|
      if yield k, v
        self.delete k
      elsif v.is_a? Hash
        self[k] = v.reject_r &block
      end
    }
  end
end

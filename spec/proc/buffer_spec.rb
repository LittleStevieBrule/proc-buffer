RSpec.describe ProcBuffer do
  it 'has a version number' do
    expect(ProcBuffer::VERSION).not_to be nil
  end

  it 'should instantiate take a array' do
    arr = [proc {}, {}, 'test']
    expect(ProcBuffer.new(arr)).to be_truthy
  end

  context 'instance' do
    before :each do
      @buffer = ProcBuffer.new
    end

    it 'should store a Proc' do
      p = proc {}
      @buffer.push(&p)
      expect(@buffer.actions.include?(p)).to eq true
    end

    it 'should buffer procs' do
      result = 1
      @buffer.push do
        result = 2
      end
      expect(result).to eq 1
    end

    it 'should run its Procs' do
      result = 1
      @buffer.push do
        result = 2
      end
      @buffer.run
      expect(result).to eq 2
    end

  end
end

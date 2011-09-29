shared_context 'a user is not signed in' do
  context 'when not signed in' do
    before(:each) do
      sign_out
    end
  end
end

shared_examples 'unauthorized access' do
end

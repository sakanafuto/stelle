require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'title' do
    it 'ページタイトルが無い場合、サイト名を返す' do
      expect(title).to eq 'Stelle'
    end

    it 'ページタイトルがある場合、ページタイトル＋サイト名を返すこと' do
      expect(title('Home')).to eq 'Home' + ' | ' + 'Stelle'
    end
  end
end

require 'test_helper'

class UserConfigTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  #https://www.timeanddate.com/worldclock/converter.html?iso=20170822T110000&p1=51
  def setup 
    @user = create(:user)#User.new(name: "Andres Arpi", email: "aarpi@itba.edu.ar", password: "123456"
    @configBsAs = build(:user_config_bsas)
    @configJerusalem = build(:user_config_jerusalem)
    @configJerusalem.user_id = @configBsAs.user_id = @user.id
  end
  
  test 'should be valid?' do
    assert @configBsAs.valid?
  end
  
  test 'should have user' do
    assert(@configBsAs.user.name =  @user.name)
  end
  
  test 'should transform start time' do
    @configBsAs.local_start_time(8)
    assert(@configBsAs.start_time == 11)
    
    @configJerusalem.local_start_time(1)
    assert(@configJerusalem.start_time == 23)
  end
  
  test 'should transform end time' do
    @configBsAs.local_end_time(22.5)
    assert(@configBsAs.end_time == 1.5)
    
    @configJerusalem.local_end_time(22)
    assert(@configJerusalem.end_time == 20)
  end

  test 'local_start not between 0-24 should throw error' do
    assert_raises(ArgumentError) { @configBsAs.local_start_time(24) }
    assert_raises(ArgumentError) { @configBsAs.local_start_time(-0.5) }
  end

  test 'local_end not between 0-24 should throw error' do
    assert_raises(ArgumentError) { @configBsAs.local_end_time(24) }
    assert_raises(ArgumentError) { @configBsAs.local_end_time(-0.5) }
  end
    
end

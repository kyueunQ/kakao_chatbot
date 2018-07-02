class KakaoController < ApplicationController

  # 값을 입력 받음
  def keyboard
    @keyboard = {
      :type => "buttons",
      :buttons => ["로또", "메뉴", "고양이", "제안서"]
    }
    render json: @keyboard
  end
  
  
  # 입력 받은 것에 대한 대답 
  def message
    @user_msg = params[:content]
    # @text = "기본 텍스트"
    
    
    if @user_msg == "로또"
      @text = (1..45).to_a.sample(6).sort.to_s
    elsif  @user_msg == "메뉴"
      @text = ["김밥카페", "땡기면", "20층"].sample
    elsif @user_msg == "고양이"
      @url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
      # 요청을 보내고, 응답을 @cat_xml로 받음
      @cat_xml = RestClient.get(@url)
      # :: 은 모듈안에 있는 것을 호출
      @cat_doc = Nokogiri::XML(@cat_xml)
      @cat_url = @cat_doc.xpath("//url").text
      # @text = @cat_url
    elsif @user_msg == "제안서"
      @text = "https://emoticonstudio.kakao.com/"
      
    end
        
    @return_msg = {
      :text => @text
    }
    @return_msg_photo = {
      :text => "고양이 고양이",
      :photo => {
        :url => @cat_url,
        :width => 720,
        :height => 630
      }
    }
    
    @return_keyboard = {
      :type => "buttons",
      :buttons => ["로또", "메뉴", "고양이", "제안서" ]
    }
    
    if @user_msg == "고양이"
      @result = {
        :message => @return_msg_photo,
        :keyboard => @return_keyboard
      }
    else
      @result = {
        :message => @return_msg,
        :keyboard => @return_keyboard
      }
    end 
    
    
    render json: @result
  
    
  end
end

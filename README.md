

cafe = Daum.find()   --> class method

cafe.is_remember?  --> instance method



DB에 중복 값이 저장되지 않도록 설정 한 것 

```
class User < ApplicationRecord
    has_secure_password
    # user_name 컬럼의 unique 속성 부여, 테이블을 바꾸는 것은 아님
    validates :user_name, uniqueness: true, presence: true
```

- presence: true => null false , 값이 무조건 있어야 함





1. gem 파일에 추가
2. 명령어를 통해 uploader을 만듦 
   - version의 오류를 줄이기 위해  whitelist를 통해 형식에 제한을 둠
   - fog
     - fog initalizers에 중요한 key를 저장해 둠
   - figaro를 통해 환경변수 설정





## 로그인 구현 - devise



`gem 'devise'`

` $ rails g devise:install ` : 4가지 정도의 너 했니? 확인 사항을 물어봄





*config/environments/development.rb*

```
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  # 회원가입시 확인 메일 보내기
  # 실제 서버 배포시 제작한 서버의 것으로 수정하기
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```







> 개발/test/배포 환경 3가지가 존재함
>
> <%- %> : <br/>과동일한 기능





## Kakao Chatbot

: 서버와 서버가 통신 (고객 - 카카오 서버 - 서버)



### 플러스친구 관리자센터 가입

- [스마트채팅] - 'API형' 선택
- https://github.com/plusfriend/auto_reply/blob/master/README.md#63-photo 해당 자료 참고해서 API 형태 파악하기



```ruby
result(hash)
	# keyboard로 request 요청을 보내면 2가지 종류로 답할 예정
	message(message타입 : hash)
		# 3가지 방식으로 답할 수 있음
		text(String 타입)
		photo(Photo 타입)
			#3가지 요소를 통해 답을 완성함
			url(String)
			width(Int)
			
		message_button(MesaageButton)
	keyboard(Keyboard타입 : hash
        # 2가지 방식으로 답할 수 있음
        type(String 타입)
        buttons(Array[String]타입)
```



### Deploy (배포하기) 



1. *Gemfile*

```
# Use sqlite3 as the database for Active Record
# 올리려는 heroku에서는 sqlite를 사용하지 x
gem 'sqlite3', :group => :development
# 배포 환경은 이렇게 사용할 거야
gem 'pg', '~> 0.18', :group => :production
gem 'rails_12factor', :group => :production
```



2. */config/database.yml 

```
production:
  <<: *default
  adapter: postgresql
  encoding: unicode
```



3. 원격 저장소에 올리기

`$ heroku create kakao-bot-kyu `

`$ git push heroku master`





>  @@msg = ObjectMaker::Message.new 
>
> 클래스 변수 선언 
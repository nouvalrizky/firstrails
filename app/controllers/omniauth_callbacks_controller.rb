class OmniauthCallbacksController < ApplicationController
    def twitter
        Rails.logger.info auth

        # Code ini akan mencari user di database dengan username yang sama dari response, jika ada ambil, namun jika tidak buatkan records baru dengan username tersebut.
        twitter_accounts = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize

        # Otomatis object twitter_accounts akan memiliki user entah itu user lama, ataupun user baru. Kemudian perbarui data dengan data dari response
        twitter_accounts.update(
            name: auth.info.name,
            username: auth.info.nickname,
            image: auth.info.image,
            token: auth.credentials.token,
            secret: auth.credentials.secret
        )

        redirect_to twitter_accounts_path, notice: "Successfully connect to Twitter"
    end

    def auth
        request.env['omniauth.auth']
    end
    
end
Rails.application.routes.draw do

  #管理者側 skipで不要なルーティング削除
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  #ユーザー側
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions",
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    delete 'users/guest_sign_out', to: 'users/sessions#guest_sign_out'
  end

  #namespaceでグループ化してそれぞれ管理。
  #管理者側
  namespace :admin do
    #登録ユーザー管理
    resources :users, only: [:index, :show] do
      #登録ユーザー凍結
      resource :freeze, only: [:create, :destroy]
    end

    #凍結中ユーザー管理
    resources :freezes, only: :index

    #レビュー投稿管理
    resources :cars, only: [:index, :show, :destroy]
  end


  #ユーザー側 scopeでpublicディレクトリ以下にルーティング
  scope module: :public do
    root to: "homes#top"
    get 'homes/about'

    #キーワード検索
    get "/search" => "searches#search"

    resources :users, only: [:show, :edit, :update] do
      #退会
      get 'users/unsubscribe'
      patch 'users/withdraw'

      #フォロー
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end

    #レビュー投稿
    resources :cars do
      #いいね
      resource :favorites, only: [:create, :destroy]
      #コメント
      resources :comments, only: [:create, :destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

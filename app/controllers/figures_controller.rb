class FiguresController < ApplicationController

    get '/figures' do
        @figures = Figure.all
        erb :'figures/index'
    end

    get '/figures/new' do
        @landmarks = Landmark.all
        @titles = Title.all
        erb :'figures/new'
    end

    post '/figures' do
      #binding.pry
        @figure = Figure.create(params[:figure])

        if !params[:landmark][:name].empty?
          @landmark = Landmark.create(params[:landmark])
          @figure.landmarks << @landmark
          # binding.pry
          @figure.save
        end

        if !params[:title][:name].empty?
          @title = Title.create(params[:title])
          @figure.titles << @title
          @figure.save
        end

        redirect to("/figures/#{@figure.id}")
    end

    get '/figures/:id' do
        @figure = Figure.find(params[:id])
        # @titles = @figure.titles
        # @landmarks = @figure.landmarks

        erb :'figures/show'
    end

    get '/figures/:id/edit' do
      @landmarks = Landmark.all
      @titles = Title.all
      @figure = Figure.find(params[:id])
      erb :'figures/edit'
    end

    patch '/figures/:id' do
      #binding.pry
      @figure = Figure.find(params[:id])
      @figure.update(params[:figure])
      if params[:landmark][:name].empty?
        @figure.landmark_ids = []
        @figure.save
      end

      if !params[:landmark][:name].empty?
        @landmark = Landmark.create(params[:landmark])
        @figure.landmarks << @landmark
        # binding.pry
        @figure.save
      end
      redirect to "/figures/#{@figure.id}"
    end

end

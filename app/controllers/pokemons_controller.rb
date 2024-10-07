class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :update, :destroy, :capture]

  # GET /pokemons
  def index
    @pokemons = Pokemon.all
    render json: @pokemons
  end

  # GET /pokemons/:id
  def show
    render json: @pokemon
  end

  # POST /pokemons
  def create
    @pokemon = Pokemon.new(pokemon_params)

    if @pokemon.save
      render json: @pokemon, status: :created
    else
      render json: @pokemon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pokemons/:id
  def update
    if @pokemon.update(pokemon_params)
      render json: @pokemon
    else
      render json: @pokemon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pokemons/:id
  def destroy
    @pokemon.destroy
    head :no_content
  end

  # POST /pokemons/:id/capture
  def capture
    if @pokemon.update(captured: true, capture_date: Time.current)
      render json: @pokemon, status: :ok
    else
      render json: @pokemon.errors, status: :unprocessable_entity
    end
  end

  # GET /pokemons/captured
  def captured
    @pokemons = Pokemon.where(captured: true)
    render json: @pokemons
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Pokémon no encontrado' }, status: :not_found
  end

  def pokemon_params
    params.require(:pokemon).permit(:name, :types, :image, :captured, :capture_date)
  end
end
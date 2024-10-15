# frozen_string_literal: true

class VotesController < ApplicationController
  before_action :set_tierlistitem

  def create
    vote_type = params[:vote_type]

    # `vote_type`が正しく渡されているかをチェックします
    unless %w[up stay down].include?(vote_type)
      flash[:error] = 'Invalid vote type.'
      redirect_to @tierlistitem.tierlist and return
    end

    vote = @tierlistitem.votes.build(vote_type:)

    if vote.save
      @tierlistitem.adjust_position
      flash[:success] = 'Vote registered!'
    else
      flash[:error] = 'Unable to register vote.'
    end
    redirect_to @tierlistitem.tierlist
  end

  private

  def set_tierlistitem
    @tierlistitem = Tierlistitem.find(params[:tierlistitem_id])
  end
end

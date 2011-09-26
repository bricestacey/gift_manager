module Books
  class BaseController < ApplicationController
    # Any implementing class must implement a `find_context` method to set `@context` to the 
    # appropriate ActiveRecord::Relation.
    before_filter :find_context

    respond_to    :html
    before_filter :find_resource, :only => [:show, :edit, :update, :destroy]
    hide_action   :current_scope, :find_resource

    def index
      @context = @context.page params[:page]
      @context = @context.send(current_scope) if current_scope

      @books = @context
    end

    def show
    end

    def new
      @book = @context.new
    end

    def edit
    end

    def create
      @book = @context.new(params[:book])

      # Save the last donor to speed up the process
      session[:donor_id] = params[:book][:donor_id]

      unless @book.isbn.blank?
        @book.attributes = OCLC.find_by_isbn(@book.isbn)
        @book.attributes = AMZN.find_by_isbn(@book.isbn)
      end

      if @book.save
        flash[:notice] = 'You successfully added a book.'
        redirect_to :action => 'show', :id => @book.id
      else
        render :new
      end
    end

    def update
      @book.attributes = params[:book]

      if @book.save
        flash[:notice] = case params[:book][:recommendation]
          when 'keep'
            "The book's recommendation has been updated to: keep."
          when 'toss'
            "The book's recommendation has been updated to: toss."
          when 'undecided'
            "The book's recommendation has been updated to: undecided."
          else
            "You successfully updated the book."
        end

        redirect_to :action => 'show', :id => @book.id
      else
        render :edit
      end
    end

    def destroy
      if @book.destroy
        flash[:notice] = 'You successfully deleted the book.'
        redirect_to :action => 'index'
      else
        flash[:error] = 'There was a problem removing the book. Please try again.'
        redirect_to :action => 'index'
      end
    end

    private
    def find_resource
      @book = @context.find(params[:id])
    end

    def current_scope
      Book.scopes.include?(params[:scope].try(:to_sym)) ? params[:scope] : nil
    end
  end
end

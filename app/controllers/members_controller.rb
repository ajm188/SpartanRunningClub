class MembersController < ApplicationController
  skip_before_filter :authorize, only: [:index, :officers]
  before_filter :authorize_as_officer, only: [:new, :create, :edit_members]
  before_filter :authorize_as_officer_or_self, only: [:edit, :update, :destroy]

	before_action :set_member, only: [:show, :edit, :update, :destroy]

  def autocomplete
    name_search = "concat(first_name, ' ', last_name) LIKE"
    name_search << " '%#{params[:term].gsub(/ /, '%')}%'"
    case_id_search = "case_id LIKE '%#{params[:term]}%'"
    # members = Member.where(name_search << ' OR ' << case_id_search)
    #                 .limit(5)
    #                 .pluck(:id, :first_name, :last_name)
    # render json: members.map do |m|
    #   {label: m[1], value: m[0]}
    # end
    render json: Member.where(name_search + ' OR ' + case_id_search)
                        .limit(5)
                        .pluck(:id, :first_name, :last_name, :case_id)
                        .map { |m| {label: "#{m[1]} #{m[2]} (#{m[3]})", value: m[0]} }
  end

	def index
		@members = Member.alphabetical
	end

  def competitive
    @competitive_members = Member.competitive.alphabetical
  end

  def non_competitive
    @non_competitive_members = Member.non_competitive.alphabetical
  end

  def officers
    @officers = Member.officers.alphabetical
  end

	def show
	end

	def new
    @member = Member.new
 	end

 	def create
 		@member = Member.new member_params

 		respond_to do |format|
 			if @member.save
 				MemberMailer.welcome_email(@member).deliver
 				format.html { redirect_to @member }
 				format.json { render action: 'show', status: :created, location: @member }
 			else
 				format.html { render action: 'new' }
 				format.json { render json: @member.errors, status: :unprocessable_entity }
 			end
 		end
 	end

  def edit
  end

  def update
    if @member.update member_params
      redirect_to @member, notice: 'Member was successfully updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to edit_members_path}
    end
  end

  def edit_all
    @members = Member.all
  end

	private

	def set_member
		@member = Member.find(params[:id]) if params[:id]
	end

	def member_params
		params.require(:member).permit(:first_name, :last_name, :case_id, :year, :competitive, :officer, :position, :email, :password)
	end
end

class ImportController < ApplicationController
  include Hydra::Controller::ControllerBehavior

  # JL : 14/02/2019 Put security (admin level) around the ingest screen
  before_action :authenticate_user!
  before_action :ensure_admin!

  def ensure_admin!
      authorize! :read, :admin_dashboard
  end

  def picker

    #byebug
    parent_type = 'no_parent'
    parent_id = '000000000'
    image_type = 'LO'

    object_model = params[:object_model]

    #byebug
    new_object_type = params[:import_object_type]
    # base_folder = 'spec/fixtures/'
    sub_folder = String.new
    #params[:sub_folder]
    file_name = params[:ingest_input_file]

    parent_id = params[:parent_code]
    parent_type = params[:parent_type]

    if parent_type ==  'no_parent'
      parent_id = '000000000'
    end

    image_type = params[:image_type]
    # byebug
    # TODO : Need to get this controller to work with Folios, Works and Collections - depending on input

    #work_file_example = 'spec/fixtures/Named_Collection_Example_OBJECT RECORDS_v3.6_20181207.xml'

    #file_example = 'spec/fixtures/Named_Collection_Example_PARTS_RECORDS_v3.6_20181207.xml'
    #parent = 'f1881k888'
    #byebug

    #testing = Rails.application.config.ingest_folder
    #byebug
    if new_object_type == "folio(s)"
      #admin_set_id =  AdminSet.find_or_create_default_admin_set_id
      artefactClass = Folio
      FoxmlImporter.new(object_model,current_user, file_name, parent_id, parent_type, image_type).import(artefactClass)
    end

    if new_object_type == "subseries(s)"
      artefactClass = Subseries
      FoxmlImporter.new(object_model,current_user, file_name, parent_id, parent_type, image_type).import(artefactClass)
    end

    if new_object_type == "work(s)"
        artefactClass = Work
        FoxmlImporter.new(object_model, current_user,file_name, parent_id, parent_type, image_type).import(artefactClass)
    end

    flash[:notice] = "Ingest has been submitted"
    #if new_object_type == "collection(s)"
    #    XmlCollectionImporter.new(current_user, work_file_example).import
    #end


  end


  def index

  end
end

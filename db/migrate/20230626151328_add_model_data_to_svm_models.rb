class AddModelDataToSvmModels < ActiveRecord::Migration[7.0]
  def change
    add_column :svm_models, :model_data, :text unless column_exists?(:svm_models, :model_data)
  end
end


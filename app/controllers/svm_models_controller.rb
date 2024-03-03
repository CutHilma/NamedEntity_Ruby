class SvmModelsController < ApplicationController
    require 'rumale'

    # Prepare training data
    @data_latih = [
        ["Saya sedang berlibur di Bali.", 1],
        ["Perjalanan ke Jogja sangat menyenangkan.", 1],
        ["Rumah saya berada di Jakarta Selatan.", 1],
        ["Kantor pusat perusahaan berlokasi di Surabaya.", 1],
        ["Saya akan pergi besok.", -1],
        ["Mengunjungi Monas di pusat kota Jakarta.", 1],
        ["Desa ini terletak di pinggir sungai.", -1],
        ["Restoran favorit saya ada di Semarang.", 1],
        ["Kami akan bermain di pantai Lombok.", 1],
        ["Stasiun kereta api Malang", 1],
        ["Menghadiri konferensi di hotel Bali.", 1],
        ["Rumah sakit terbesar berada di Makassar.", 1],
        ["Toko buku tersebut ada di Malang.", 1],
        ["Kampus universitas ini terletak di Bandar Lampung.", 1],
        ["Saya tinggal di daerah perumahan Tangerang.", 1],
        ["Mengikuti acara di gedung pertemuan Surakarta.", 1],
        ["Pulau indah ini berada di Raja Ampat.", 1],
        ["Mengunjungi museum sejarah!", -1],
        ["Kafe ini terkenal di Medan.", 1],
        ["Perusahaan kami memiliki cabang di Palembang.", 1],
        ["Walikota Lhokseumawe dan Bupati Bireuen melakukan pertemuan di Pendopo Bireuen", 1],
        ["Walikota Banda Aceh dan Wakil Walikota Langsa melakukan pertemuan di Langsa", 1]
      ]
  
    def train
      
  
      # Initialize lists for feature and label data
      data_features = []
      data_labels = []
  
      # Extract features and labels from training data
      # @data_latih.each do |data|
      #   teks = data[0]
      #   label = data[1]
  
      #   features = extract_features(teks)
  
      #   data_features << features.values
      #   data_labels << label.to_i
      # Check for nil before using each
      if @data_latih
        @data_latih.each do |data|
          teks = data[0]
          label = data[1]

          features = extract_features(teks)
  
          data_features << features.values
          data_labels << label.to_i
          # ... rest of your code
      end
      else
        # Handle the case when @data_latih is nil
        puts "@data_latih is nil"
      end
    end
  
      
      # # Perform one-hot encoding for features
      # unique_features = data_features.flatten.uniq.map(&:to_s).sort
      # encoded_features = data_features.map do |features|
      #   one_hot_encoding(features, unique_features)
      # end
  
      # Train the SVM model
      model = Rumale::LinearModel::SVC.new
      # model.fit(encoded_features, data_labels)
  
      # Save the trained model to the database
      SvmModel.create(model_data: Marshal.dump(model))
      # Prepare training progress data
        training_progress = {
        total_data: @data_latih.size,
        completed_data: @data_latih.size
        }

        # Render the view with training progress data
         render :train, locals: { training_progress: training_progress }
  
      render plain: 'SVM training completed.'
    data_latih = self.class.instance_variable_get(:@data_latih)

    # # Initialize lists for feature and label data
    # data_features = []
    # data_labels = []

    # # Extract features and labels from training data
    # data_latih.each do |data|
    #   teks = data[0]
    #   label = data[1]

    #   features = extract_features(teks)

    #   data_features << features.values
    #   data_labels << label.to_i
    # end

    # # Perform one-hot encoding for features
    # unique_features = data_features.flatten.uniq.map(&:to_s).sort
    # encoded_features = data_features.map do |features|
    #   one_hot_encoding(features, unique_features)
    # end

    # # Train the SVM model
    # model = Rumale::LinearModel::SVC.new
    # model.fit(encoded_features, data_labels)

    # # Predict labels for the training data
    # training_predictions = model.predict(encoded_features)

    # # Save the trained model to the database
    # SvmModel.create(model_data: Marshal.dump(model))

    # # Prepare the training data for display
    # @training_data = @data_latih.map.with_index do |data, index|
    #   { text: data[0], label: data[1], prediction: training_predictions[index] }
    # end
    # # Calculate the training progress
    # training_progress = {
    # total_data: data_latih.length,
    # completed_data: training_predictions.length
    # }
    # # render 'train', locals: { training_predictions: training_predictions }
    # # Render the view with training progress data
    # render :train, locals: { training_progress: training_progress }
    # # render 'train'
    # end
  
    # # def predict
    # #   # Fetch the caption from the request parameters
    # #   caption = params[:caption]
  
    # #   # Fetch the SVM model from the database
    # #   model = Marshal.load(SvmModel.last.model_data)
  
    # #   # Perform feature extraction on the caption
    # #   features = extract_features(caption)
  
    # #   # Perform one-hot encoding for features
    # #   unique_features = model.classes
    # #   encoded_features = one_hot_encoding(features.values, unique_features)
  
    # #   # Predict the label using the SVM model
    # #   predicted_label = model.predict([encoded_features])
  
    # #   # Prepare the prediction data for display
    # #   @predictions = [{ caption: caption, predicted_label: predicted_label[0] }]
  
    # #   render :predict
    # # end

    # # def predict
    # #     # Retrieve the input text from the form
    # #     input_text = params[:input_text]
      
    # #     # Extract features from the input text
    # #     fitur = extract_features(params[:input_text])
      
    # #     # Perform one-hot encoding for features
    # #     encoded_features = one_hot_encoding(features.values, unique_features)
      
    # #     # Predict the label using the SVM model
    # #     predicted_label = @model.predict([encoded_features])[0]
      
    # #     # Prepare the prediction data for display
    # #     @prediction_data = {
    # #       input_text: input_text,
    # #       first_label: features['first_label'],
    # #       predicted_label: predicted_label
    # #     }
      
    # #     render :predict
    # # end

    # # def predict
    # #     data_latih = self.class.instance_variable_get(:@data_latih)

    # #     @model = Marshal.load(SvmModel.last.model_data) # Fetch the SVM model from the database
    # #     @unique_features = @model.classes # Perform one-hot encoding for features
    # #     @predictions = []
      
    # #     data_latih.each do |data|
    # #       teks = data[0]
    # #       label = data[1]
      
    # #       features = extract_features(teks) # Extract features for the text
      
    # #       # Perform one-hot encoding for features
    # #       encoded_features = one_hot_encoding(features.values, @unique_features)
    # #         encoded_features = encoded_features.flatten

      
    # #       # Predict the label using the SVM model
    # #     #   predicted_label = @model.predict([encoded_features])[0]
    # #         encoded_features = Numo::DFloat.cast(encoded_features)
    # #         reshaped_features = encoded_features.reshape(1, -1)
    # #         Xpredicted_label = @model.predict(reshaped_features)[0]
        
        

      
    # #       @predictions << { teks: teks, label: label, predicted_label: predicted_label }
    # #     end
    # # end
    
    # # def predict
    # #     data_latih = self.class.instance_variable_get(:@data_latih)
      
    # #     @model = Marshal.load(SvmModel.last.model_data) # Fetch the SVM model from the database
    # #     @unique_features = @model.classes # Perform one-hot encoding for features
    # #     @predictions = []
      
    # #     data_latih.each do |data|
    # #       teks = data[0]
    # #       label = data[1]
      
    # #       features = extract_features(teks) # Extract features for the text
      
    # #       # Perform one-hot encoding for features
    # #       encoded_features = one_hot_encoding(features.values, @unique_features)
    # #       encoded_features = encoded_features.flatten
      
    # #       # Reshape the encoded features array
    # #       encoded_features = Numo::DFloat.cast(encoded_features)
    # #       encoded_features = encoded_features.reshape(1, -1)
      
    # #       # Predict the label using the SVM model
    # #       predicted_label = @model.predict(encoded_features)[0]
      
    # #       @predictions << { teks: teks, label: label, predicted_label: predicted_label }
    # #     end
    # # end
    # def predict
    #     data_latih = self.class.instance_variable_get(:@data_latih)
      
    #     @model = Marshal.load(SvmModel.last.model_data) # Fetch the SVM model from the database
    #     # @unique_features = @model.classes # Perform one-hot encoding for features
    #     @predictions = []
      
    #     data_latih.each do |data|
    #       teks = data[0]
    #       label = data[1]
      
    #       features = extract_features(teks) # Extract features for the text
      
    #       # # Perform one-hot encoding for features
    #       # encoded_features = one_hot_encoding(features.values, @unique_features)
    #       # encoded_features = Numo::DFloat.cast(encoded_features)
      
    #       # Predict the label using the SVM model
    #       predicted_label = @model.predict(encoded_features)
      
    #       @predictions << { teks: teks, label: label, predicted_label: predicted_label }
    #     end
    # end
      
            

    private
  
    # def extract_features(teks)
    #   fitur = {}
  
    #   if teks.present?
    #     # Feature: Number of words in the text
    #     jumlah_kata = teks.split.size
    #     fitur['jumlah_kata'] = jumlah_kata
    
    #     # Feature: Identified location entities
    #     entitas_lokasi = identifikasi_entitas_lokasi(teks)
    #     fitur['entitas_lokasi'] = entitas_lokasi
    #   end
  
    #   fitur
    # end
    def extract_features(teks)
        fitur = {}
      
        # # Feature: Number of words in the text
        # jumlah_kata = teks.to_s.split.size
        # fitur['jumlah_kata'] = jumlah_kata

        # Feature: Number of words in the text
        jumlah_kata = teks.nil? ? 0 : teks.split.size
        fitur['jumlah_kata'] = jumlah_kata

        # # Feature: Number of words in the text
        # if teks.nil?
        #     jumlah_kata = 0
        # else
        #     jumlah_kata = teks.split.size
        # end
        # fitur['jumlah_kata'] = jumlah_kata

      
        # Feature: Identified location entities
        entitas_lokasi = identifikasi_entitas_lokasi(teks)
        fitur['entitas_lokasi'] = entitas_lokasi
      
        # Add default features to ensure consistent feature set
        fitur['default_feature_1'] = 0
        fitur['default_feature_2'] = 0
      
        fitur
    end
      
    def identifikasi_entitas_lokasi(teks)
      entitas_lokasi = []
      kata_pengenalan = ['di', 'ke', 'berada', 'ada', 'terletak', 'kota', 'di pinggir']
  
      teks_split = teks.nil? ? [] : teks.split()
      i = 0
      while i < teks_split.length - 1
        word1 = teks_split[i].downcase
        word2 = teks_split[i + 1]
  
        if kata_pengenalan.include?(word1) && word2.capitalize == word2
          entitas_lokasi << word2
        end
  
        i += 1
      end
  
      entitas_lokasi
    end
  
    # # def one_hot_encoding(features, unique_values)
    # #   encoding = []
    # #   unique_values.each do |value|
    # #     encoding << (features.include?(value) ? 1 : 0)
    # #   end
    # #   encoding
    # # end
    # # def one_hot_encoding(features, unique_values)
    # #     encoding = []
    # #     unique_values.each do |value|
    # #       encoding << (features.include?(value.to_s) ? 1 : 0)
    # #     end
      
    # #     # Add default feature values to the encoding
    # #     # encoding << features['default_feature_1']
    # #     # encoding << features['default_feature_2']
      
    # #     encoding
    # # end      
    # def one_hot_encoding(features, unique_values)
    #     encoding = []
    #     unique_values.each do |value|
    #       encoding << (features.include?(value.to_s) ? 1 : 0)
    #     end
      
    #     [encoding]  # Return a 2D array with shape (1, n)
    end
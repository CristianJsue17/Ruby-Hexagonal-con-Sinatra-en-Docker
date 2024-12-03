class ImageUploader < CarrierWave::Uploader::Base
  # Almacenamiento en el sistema de archivos local
  storage :file

  # Directorio donde se guardarán los archivos subidos
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Opcional: Puedes añadir validaciones de archivos
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  # Opcional: Límite de tamaño de archivo
  def size_range
    1..5.megabytes
  end
end
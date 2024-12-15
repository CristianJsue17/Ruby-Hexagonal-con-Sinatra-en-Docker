class Auth   #core de negocio, solo logica nd de DB


  def initialize
    @email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    @password_regex = /\A(?=.*[A-Z])(?=.*\d)(?=.*[.,])(?=.*[a-zA-Z\d.,]).{8,}\z/
  end

  def login(email,password)
    if validateSqlInjection(email,password)
      {email: email, password:password}
    else
      nil
    end
  end



  def singUp(email,password)
    if validateFormCredentials(email,password) && validateSqlInjection(email,password)
      {email:email, password: password}
    else
      nil
    end
  end

  private
  def validateFormCredentials(email,password)
    if @email_regex.match(@email) && @password_regex.match(@password)
      true
    else
      false
    end
  end

  private
  def validateSqlInjection(email,password)
    # falta implementar
    true
  end

end
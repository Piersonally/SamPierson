module DiagnosticMessaging

  def notice(message)
    puts message if @verbose
  end

  def error(message)
    puts message unless @quiet
  end
end

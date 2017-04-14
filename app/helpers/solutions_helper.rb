module SolutionsHelper
  def code_to_string(code)
    return "Not answer yet" if code.nil?
    code = code.to_i
    return "Compile Error" if code == 1
    return "Runtime Error" if code == 2
    return "Time Limit Exceeded" if code == 3
    return "OK" if code == 4
    return "White spaces" if code == 5
    return "Wrong Answer"
    # 1 compile error
    # 2 runtime error
    # 3 timelimit exceeded
    # 4 OK
    # 5 White spaces
    # 6 Wrong answer

  end
end

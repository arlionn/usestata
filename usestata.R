
#--------------  function: usestata() ------------------

#' ChatGPT --------------- 2024/10/11 23:57
#'    https://chatgpt.com/share/67094ac1-7474-8005-8e82-76899111f2cb

#' Usage -----------------
#'   df <- usestata("nlsw88")  # read 'nlsw88.dta' into R

#' Author: Yujun Lian
#' Version: 1.01, 21 Oct 2024

##====================================================================
# 加载必要的包
if (!requireNamespace("haven", quietly = TRUE)) {
  stop("请安装 'haven' 包以读取 Stata 数据。")
}

if (!requireNamespace("stringr", quietly = TRUE)) {
  stop("请安装 'stringr' 包以进行字符串操作。")
}

if (!requireNamespace("httr", quietly = TRUE)) {
  stop("请安装 'httr' 包以进行 URL 验证。")
}

# 定义 usestata 函数
usestata <- function(data_name, version = 18) {
  # 参数验证
  if (!is.character(data_name) || nchar(data_name) == 0) {
    stop("data_name 必须是一个非空字符。")
  }
  
  if (!is.numeric(version) || version < 0 || version != as.integer(version)) {
    stop("version 必须是一个非负整数。")
  }
  
  # 构建基础 URL，使用版本号
  base_url <- stringr::str_c("https://www.stata-press.com/data/r", version, "/")
  data_url <- stringr::str_c(base_url, data_name, ".dta")
  
  # 检查 URL 是否有效
  if (httr::http_error(data_url)) {
    stop("生成的 URL 无效: ", data_url)
  }
  
  # 尝试读取数据，如果失败则提示用户
  tryCatch({
    # 读取 Stata 数据
    data <- haven::read_stata(data_url)
    
    # 将数据赋值给 data_name 变量
    assign(data_name, data, envir = .GlobalEnv)
    
    # 返回数据及其相关信息
    result <- list(data = data, name = data_name, rows = nrow(data), cols = ncol(data))
    return(result)
  }, error = function(e) {
    # 如果读取失败，输出提示信息
    message("无法读取数据集 '", data_name, "'，请检查文件名是否正确。")
    message("生成的 URL: ", data_url)
    message("请访问 https://www.stata-press.com/data/r", version, "/ 查验数据文件名称是否正确。")
  })
}
##====================================================================

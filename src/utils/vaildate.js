// 用户名检验
export function nameRule(rule, value, callback) {
  if (value === "") {
    callback(new Error("请输入用户名"));
  } else {
    callback();
  }
}

// 密码检验
export function passRule(rule, value, callback) {
  if (value === "") {
    callback(new Error("请输入密码"));
  } else {
    callback();
  }
}

// 添加本体存储token
export function setToken(tokenkey, token) {
  return localStorage.setItem(tokenkey, token);
}
// 获取token
export function getToken(tokenKey) {
  return localStorage.getItem(tokenKey);
}
// 删除token
export function removeToken(tokenKey) {
  return localStorage.removeItem(tokenKey);
}

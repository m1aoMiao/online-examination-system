import Vue from "vue";
import VueRouter from "vue-router";
Vue.use(VueRouter);

const Login = () => import("../views/Login.vue");
const Registered = () => import("../views/changePassword.vue");

// 普通用户界面
const UserHome = () => import("../views/user/indexPage.vue");
const UserAnswer = () => import("../views/user/AnswerPage.vue");
const UserAnswerDetail = () => import("../views/user/AnswerDetail.vue");
const UserSubmit = () => import("../views/user/SubmitPage.vue");
// 管理员界面
const AdminHome = () => import("../views/admin/indexPage.vue");
const AdminSetting = () => import("../views/admin/settingPage.vue");
const AdminUpload = () => import("../views/admin/uploadTitle.vue");
// 阅卷人界面
const OperatorHome = () => import("../views/operator/indexPage.vue");
const OperatorAnswer = () => import("../views/operator/answerDetail.vue");
const OperatorGrade = () => import("../views/operator/gradePage.vue");

// 公共的路由
const routes = [
  {
    path: "/login",
    name: "Login",
    component: Login,
  },
  {
    path: "/changePassword",
    name: "changePassword",
    component: Registered,
  },

  {
    path: "/userhome",
    component: UserHome,
    name: "user-home",
    meta: {
      name: "用户首页",
      icon: "icon-home",
    },
    children: [
      {
        path: "list/:unit_id",
        name: "user-answer",
        component: UserAnswer,
        meta: {
          name: "答题页面",
          icon: "icon-list",
        },
      },
      {
        path: "detail/:unit_id/:stuId",
        name: "user-answer-detail",
        component: UserAnswerDetail,
        meta: {
          name: "详情页面",
          icon: "icon-list",
        },
      },
      {
        path: "success",
        name: "user-submit",
        component: UserSubmit,
        meta: {
          name: "提交成功",
          icon: "icon-check",
        },
      },
    ],
  },
  {
    path: "/adminhome",
    name: "admin-home",
    component: AdminHome,
    meta: {
      name: "管理员首页",
      icon: "icon-home",
    },
    children: [
      {
        path: "setting/:unit_id",
        name: "admin-setting",
        component: AdminSetting,
        meta: {
          name: "设置阅卷人",
          icon: "icon-list",
        },
      },
      {
        path: "upload/:unit_id",
        name: "admin-upload",
        component: AdminUpload,
        meta: {
          name: "上传题目",
          icon: "icon-list",
        },
      },
    ],
  },
  {
    path: "/operatorhome",
    name: "operator-home",
    component: OperatorHome,
    meta: {
      name: "阅卷人首页",
      icon: "icon-home",
    },
    children: [
      {
        path: "detail/:unitId",
        name: "operator-detail",
        component: OperatorAnswer,
        meta: {
          name: "某次答题界面",
          icon: "icon-list",
        },
      },
      {
        path: "answer/:unit_id/:stuId",
        name: "operator-grade",
        component: OperatorGrade,
        meta: {
          name: "批改界面",
          icon: "icon-list",
        },
      },
    ],
  },
  {
    path: "*",
    redirect: { name: "Login" },
  },
];

const router = new VueRouter({
  mode: "history",
  base: "/online-examination/",
  routes,
});

export default router;

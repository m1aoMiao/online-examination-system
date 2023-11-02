<template>
  <div class="adminindex">
    <top-head></top-head>
    <router-view></router-view>
    <div class="body" v-if="isAdminHome">
      <el-dialog title="新建试卷" :visible.sync="dialogFormVisible">
        <el-form :model="form">
          <el-form-item prop="unitTitle" :rules="rules">
            <el-input
              v-model="form.unit_name"
              autocomplete="off"
              placeholder="输入试卷标题"
            ></el-input>
          </el-form-item>
          <el-form-item prop="unitStart" :rules="rules">
            <el-date-picker
              v-model="form.start_time"
              type="date"
              style="width: 100%"
              placeholder="选择答题开始日期"
              format="yyyy-MM-dd HH:mm:ss"
            >
            </el-date-picker>
          </el-form-item>
          <el-form-item prop="unitEnd" :rules="rules">
            <el-date-picker
              v-model="form.end_time"
              type="date"
              style="width: 100%"
              placeholder="选择答题截止日期"
              format="yyyy-MM-dd HH:mm:ss"
            >
            </el-date-picker>
          </el-form-item>
          <el-form-item prop="unitContent" :rules="rules">
            <el-input
              v-model="form.unit_description"
              type="textarea"
              autocomplete="off"
              placeholder="输入试卷描述"
            ></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="upLoadnewNuit">确 定</el-button>
        </div>
      </el-dialog>

      <el-card class="box-card" style="cursor: pointer">
        <div class="newTitle" @click="dialogFormVisible = true">
          <span class="iconfont icon-jia"></span>
          <p style="font-size: 2vh; font-weight: 800">新建试卷</p>
        </div>
      </el-card>
      <el-card class="box-card" v-for="item in list" :key="item.unit_id">
        <div class="item-info">
          <p class="item-title">{{ item.unit_name }}</p>
          <p class="item-date">
            起止时间: {{ item.start_time }}-{{ item.end_time }}
          </p>
          <p
            class="item-body"
            v-html="item.unit_description"
            style="
              display: -webkit-box;
              -webkit-box-orient: vertical;
              -webkit-line-clamp: 3;
              overflow: hidden;
            "
          ></p>
        </div>
        <div class="Foot">
          <div class="footer">
            <span class="footer-state"
              ><p style="padding: 0">状态:</p>
              <p
                style="padding: 0"
                :class="
                  item.isLate === false ? 'activity-doing' : 'activity-end'
                "
              >
                &nbsp;{{ item.isLate === false ? "进行中" : "不在规定时间" }}
              </p></span
            >
            <el-button
              class="footer-btn"
              type="primary"
              :disabled="item.isLate === false ? false : true"
              @click="goUploadTitle(item.unit_id)"
              >上传题目</el-button
            >
            <el-button
              class="footer-btn"
              type="primary"
              @click="gosetting(item.unit_id)"
              >设置阅卷人</el-button
            >
          </div>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script>
import topHead from "../../components/topHead.vue";
import { getCompetetionList } from "../../api/index";
import { newNuit } from "../../api/admin";
export default {
  name: "admin-index",
  data() {
    return {
      newTitlte: "",
      newStart: "",
      newEnd: "",
      newContent: "",
      isAdminHome: true,
      list: [],
      form: {
        unit_name: "",
        start_time: "",
        end_time: "",
        unit_description: "",
      },
      dialogTableVisible: false,
      dialogFormVisible: false,
      formLabelWidth: "120px",
      rules: {
        unitTitle: {
          requried: true,
          message: "请输入试卷标题",
          trigger: "blur",
        },

        unitStart: [
          { requried: true, message: "请输入试卷标题", trigger: "blur" },
          {
            min: 19,
            max: 19,
            message: "请按照2000-01-01 01:01:01的格式来输入时间",
            trigger: "blur",
          },
        ],
        unitEnd: [
          { requried: true, message: "请输入试卷标题", trigger: "blur" },
          {
            min: 19,
            max: 19,
            message: "请按照xxxx-xx-xx xx:xx:xx的格式来输入时间",
            trigger: "blur",
          },
        ],
        unitContent: {
          requried: true,
          message: "请输入试卷描述",
          trigger: "blur",
        },
      },
    };
  },
  components: { topHead },
  methods: {
    gosetting(unit_id) {
      this.$router.push(`/adminhome/setting/${unit_id}`);
    },
    goUploadTitle(unit_id) {
      this.$router.push(`/adminhome/upload/${unit_id}`);
    },
    upLoadnewNuit() {
      // if (this.form.start.length !== 19 || this.form.end.length !== 19) {
      //   this.$message.warning("请按xxxx-xx-xx xx:xx:xx的格式输入时间");
      // } else {
      this.dialogFormVisible = false;

      const startdate = new Date(this.form.start_time).toLocaleString();
      const enddate = new Date(this.form.end_time).toLocaleString();
      const start = startdate.split(" ");
      this.form.start_time =
        start[0].split("/").reduce((startDate, item) => {
          return (startDate += "-" + item.padStart(2, "0"));
        }) +
        " " +
        start[1];

      const end = enddate.split(" ");
      this.form.end_time =
        end[0].split("/").reduce((endDate, item) => {
          return (endDate += "-" + item.padStart(2, "0"));
        }) +
        " " +
        end[1];

      const newNuitdata = {
        title: this.form.unit_name,
        start: this.form.start_time,
        end: this.form.end_time,
        description: this.form.unit_description,
      };
      newNuit(newNuitdata).then((res) => {
        if (res.data.msg === "新建比赛成功") {
          this.$message({
            message: "新建比赛成功",
            type: "success",
          });
          window.setTimeout(() => {
            location.reload();
          }, 1000);
        } else {
          this.$message({
            message: "新建比赛失败",
            type: "error",
          });
        }
      });
    },
  },
  mounted() {
    if (localStorage.getItem("role") === "2") {
      if (this.$router.currentRoute.path === "/adminhome") {
        getCompetetionList().then((res) => {
          const list = res.data.data;
          for (let i = 0; i < list.length; i++) {
            if (list[i].start_time && list[i].end_time) {
              let start = list[i].start_time.substr(0, 10);
              let end = list[i].end_time.substr(0, 10);
              end = end.split("-");
              start = start.split("-");
              list[i].start_time = start[1] + "月" + start[2] + "日";
              list[i].end_time = +end[1] + "月" + end[2] + "日";
            }
          }
          list.sort((a, b) => (b.isLate === true ? -1 : 0));
          this.list = list;
        });
        this.isAdminHome = true;
      } else {
        this.isAdminHome = false;
      }
    } else {
      this.$router.back();
    }
  },
  updated() {
    if (this.$router.currentRoute.path === "/adminhome") {
      this.isAdminHome = true;
    } else {
      this.isAdminHome = false;
    }
    // console.log(this.$router.currentRoute.path);
  },
};
</script>

<style scoped>
.body {
  display: flex;
  flex-direction: column;
  align-items: center;
  height: auto;
}
.box-card {
  width: 84.5vw;
  height: 24.6vh;
  margin-bottom: 3vh;
  border-radius: 1.4vh;
  display: flex;
  flex-direction: column;
  padding: 2vh 2vw;
  padding-bottom: 1vh;
  position: relative;
}
.newTitle {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-top: 5vh;
}
.icon-jia {
  font-size: 7vh !important;
  color: rgb(157, 218, 241);
}
.item-title {
  margin-top: 1vh;
  padding: 0;
  font-size: 3.3vh;
  font-weight: 700;
  letter-spacing: 0.6vh;
  line-height: 0px;
  color: rgba(33, 32, 32, 1);
}
.item-date {
  padding: 0.8vh;
  font-size: 1.5vh;
  font-weight: 500;
  letter-spacing: 0px;
  line-height: 0px;
  color: rgba(4, 134, 254, 1);
}
.item-body {
  white-space: pre-line;
  font-size: 1.6vh;
  font-weight: 400;
  letter-spacing: 0px;
  color: rgba(0, 0, 0, 0.65);
  text-align: left;
}
.footer {
  display: flex;
  flex-direction: row;
  justify-content: end;
}
.footer-state {
  display: flex;
  flex-direction: row;
  align-items: center;
  margin-right: 0.5vw;
}
.footer-btn {
  height: 4.8vh;
  margin: 0.5vw;
}
.activity-doing {
  color: red !important;
}
.newActivity {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}
.newIpt {
  width: 100%;
  height: 3vh;
  font-size: 1.6vh;
  margin: 1vh auto;
}
.newInput {
  height: 7vh;
  width: 100%;
  font-size: 1.7vh;
  margin: 1vh auto;
}
.Foot {
  position: absolute;
  bottom: 2vh;
  right: 3vw;
}
</style>

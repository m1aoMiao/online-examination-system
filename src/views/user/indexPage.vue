<template>
  <div class="userindex">
    <top-head></top-head>
    <router-view></router-view>
    <div class="body" v-if="isUserHome">
      <el-link
        style="margin-bottom: 30px"
        type="primary"
        :underline="false"
        @click="dialogTableVisible = true"
        >查看历史成绩</el-link
      >

      <el-dialog title="历史成绩" :visible.sync="dialogTableVisible">
        <el-table :data="historyScores">
          <el-table-column
            property="unit_name"
            label="考试名称"
            width="150"
          ></el-table-column>
          <el-table-column
            property="stuId"
            label="姓名"
            width="150"
          ></el-table-column>
          <el-table-column property="scores" label="考试成绩"></el-table-column>
          <el-table-column fixed="right" label="操作" key="slot">
            <template #default="scope">
              <el-link
                class="backBtn"
                type="primary"
                :underline="false"
                @click="showIndex(scope.$index, scope.row)"
                >查看试卷</el-link
              >
            </template>
          </el-table-column>
        </el-table>
      </el-dialog>
      <el-card class="box-card" v-for="item in unit_list" :key="item.unit_id">
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
                &nbsp;{{ item.isLate === false ? "进行中" : "已结束" }}
              </p>
            </span>
            <el-button
              class="footer-btn"
              type="primary"
              :disabled="item.isLate ? true : false"
              @click="golist(item.unit_id)"
              >进入答题</el-button
            >
          </div>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script>
import { getHistoryScores } from "@/api/user";
import { getCompetetionList } from "../../api/index";
import topHead from "../../components/topHead.vue";
export default {
  name: "user-home",
  data() {
    return {
      isUserHome: true,
      unit_list: [],
      dialogTableVisible: false,
      historyScores: [],
    };
  },
  components: { topHead },
  methods: {
    golist(unitId) {
      this.$router.push("/userhome/list/" + unitId);
    },
    showIndex(index, row) {
      this.$router.push(`/userhome/detail/${row.unit_id}/${row.stuId}`);
    },
  },
  async mounted() {
    if (localStorage.getItem("role") === "0") {
      if (this.$router.currentRoute.path === "/userhome") {
        getCompetetionList().then((res) => {
          const unit_list = res.data.data;
          for (let i = 0; i < unit_list.length; i++) {
            if (unit_list[i].start_time && unit_list[i].end_time) {
              let start = unit_list[i].start_time.substr(0, 10);
              let end = unit_list[i].end_time.substr(0, 10);
              end = end.split("-");
              start = start.split("-");
              unit_list[i].start_time = start[1] + "月" + start[2] + "日";
              unit_list[i].end_time = +end[1] + "月" + end[2] + "日";
            }
          }
          unit_list.sort((a, b) => (b.isLate === true ? -1 : 0));
          this.unit_list = unit_list;
        });
        this.isUserHome = true;
      } else {
        this.isUserHome = false;
      }

      let {
        data: { data },
      } = await getHistoryScores();
      console.log(data);
      this.historyScores = data;
      this.historyScores.forEach((item) => {
        item.scores = item.unit_score + "/" + item.total_score;
      });
    } else {
      this.$router.back();
    }
  },
  updated() {
    if (this.$router.currentRoute.path === "/userhome") {
      this.isUserHome = true;
    } else {
      this.isUserHome = false;
    }
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
  letter-spacing: 1px;
  line-height: 0px;
  color: rgba(4, 134, 254, 1);
}
.item-body {
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
  padding: 0;
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
.Foot {
  position: absolute;
  bottom: 2vh;
  right: 3vw;
}
</style>

<template>
  <div id="operatorindex">
    <top-head></top-head>
    <router-view />
    <div class="operator-body" v-if="isOperatorHome">
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
              </p></span
            >
            <el-button
              class="footer-btn"
              type="primary"
              @click="godetail(item.unit_id, item.unit_name)"
              >答题详情</el-button
            >
          </div>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script>
import { getCompetetionList } from "../../api/index";
import topHead from "../../components/topHead.vue";
export default {
  name: "operator-home",
  data() {
    return {
      isOperatorHome: true,
      unit_list: [],
    };
  },
  components: { topHead },
  methods: {
    godetail(unitId, unit_name) {
      this.$router.push({
        path: "/operatorhome/detail/" + unitId,
        query: { unit_name: unit_name },
      });
    },
  },
  mounted() {
    if (localStorage.getItem("role") === "1") {
      if (this.$router.currentRoute.path === "/operatorhome") {
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
        this.isOperatorHome = true;
      } else {
        this.isOperatorHome = false;
      }
    } else {
      this.$router.back();
    }
  },
  updated() {
    if (this.$router.currentRoute.path === "/operatorhome") {
      this.isOperatorHome = true;
    } else {
      this.isOperatorHome = false;
    }
  },
};
</script>

<style scoped>
.operator-body {
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
.Foot {
  position: absolute;
  bottom: 2vh;
  right: 3vw;
}
</style>

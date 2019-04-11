<%@ page import="cn.doreou.model.Goods" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.doreou.model.GoodAndUser" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/3/24
  Time: 18:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%Object goodslist = session.getAttribute("AllBuyGoodsList");
    Object userList = session.getAttribute("user");
    List<GoodAndUser> usersinfo = (List<GoodAndUser>) session.getAttribute("userinfo");
%>
    <input id="page-way" style="display: none" <%if(session.getAttribute("way")!=null){%>
           value="<%=session.getAttribute("way")%>"
        <%}else{%>
           value="asc"
        <%}%>>
    <% for (Goods g : (List<Goods>) goodslist) {%>
    <div class="itemlist clearfix">
        <div class="itembox clearfix">
            <div class="item_main">
                <div class="left">
                    <div class="userhead">
                        <%
                            for (GoodAndUser u : usersinfo) {
                                if (u.getGoods_id() == g.getGoods_id()) {
                        %>
                        <img src="<%=u.getIcon()%>">
                        <%
                                }
                            }
                        %>
                    </div>
                    <div class="username">
                        <%
                            for (GoodAndUser u : usersinfo) {
                                if (u.getGoods_id() == g.getGoods_id()) {
                        %>
                        <a target="_blank" href="/other/salenow?userid=3713"><%=u.getUsername()%>
                        </a>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
                <div class="right">
                    <div class="title">
                        <%=g.getGoods_title()%>
                    </div>
                    <div class="desc">
                        <%=g.getIntroduce()%>
                    </div>
                    <div class="attr">
                        期望价格：<span class="price"><%=g.getExpt_price()%></span> 交易地点：<span
                            class="position">宿舍</span>
                        发布时间：<span class="datetime"><%
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        String time = sdf.format(g.getTime());
                    %><%=time%></span>
                        学校：<span class="school">大连大学</span>
                    </div>
                    <div class="contact">
                        <%
                            for (GoodAndUser u : usersinfo) {
                                if (u.getGoods_id() == g.getGoods_id()) {
                        %>
                        <span class="phone">手机：<span class="telnum">
                                    <%if (u.getPhone() != null) {%>
                                        <%=u.getPhone()%>
                                    <%} else {%>
                                        ta还没有留下电话哦~
                                    <%}%>
                                                                                                                                    </span> </span>
                        <span class="qq">QQ：<span class="qqnum">
                                            <%if (u.getQq() != null) {%>
                                        <%=u.getQq()%>
                                    <%} else {%>
                                        ta还没有留下QQ哦~
                                    <%}%>                                                                                           </span>
                                        </span>
                        <span class="phone">微信：<span class="telnum">
                                                                                            <%if (u.getWechat() != null) {%>
                                        <%=u.getWechat()%>
                                    <%} else {%>
                                        ta还没有留下微信哦~
                                    <%}%>                                        </span> </span>
                        <span class="qq">用户认证状态：<span class="qqnum">
                                            <%if (u.getMember_status() == 0) {%>
                                                未认证
                                            <%} else {%>
                                                已认证
                                            <%}%>                                            </span>
                                        </span>                                                                         </span> </span>
                        <%
                                }
                            }
                        %>
                    </div>
                    <!--<a class="comment" href="javascript:showcomment(1016)">评论</a>-->
                </div>
            </div>
            <div id="item1016" class="item_comments" style="display: none;">
                <div class="comment_wr">
                </div>
            </div>
        </div>
    </div>

    <%}%>

<template>
  <li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" aria-haspopup="true" v-pre>
        Notifications <span class="caret"></span>
    </a>

    <ul class="dropdown-menu">
      <li v-for="n in notifications" @click="markAsRead(n.id)">
        {{ n.actor.email }} {{ n.action }} {{ n.notifiable.title }}
      </li>

      <hr>
    </ul>    
  </li>
</template>

<script type="text/javascript">
  export default {
    created() {
      axios.get('/notifications')
           .then(({data}) => {
              this.notifications = data.data.map(n => n.attributes);
           })
    },
    data() {
      return {
        notifications: []
      }
    },
    methods: {
      markAsRead(id) {
        axios.post(`/notifications/${id}/read`)
             .then(({data}) => {
              console.log(data)
              window.location.href = data.post_read_path
             })
      }
    }
  }
</script>
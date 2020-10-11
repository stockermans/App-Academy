const APIUtil = {
  followUser: (id) => {
    return $.ajax({
      url: `/users/${id}/follow`,
      type: 'POST',
      dataType: 'json'
    })
  },

  unfollowUser: (id) => {
    return $.ajax({
      url: `/users/${id}/follow`,
      type: 'DELETE',
      dataType: 'json'
    })
  },

  searchUsers: (queryVal) => {
    let data = { query: queryVal };
    return $.ajax({
      url: `/users/search`,
      type: 'GET',
      dataType: 'json',
      data: data
    })
  }
};

module.exports = APIUtil;
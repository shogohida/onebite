const initSyncBtn = () => {
  const syncBtn = document.querySelector(".btn-sync")
  if (syncBtn) {
    syncBtn.addEventListener("click", () => {
      const loadingCtn = document.querySelector(".loading-container")
      if (loadingCtn) loadingCtn.classList.add("loading")
      syncBtn.remove()
    })
  }
}


export { initSyncBtn }

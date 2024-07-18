import './clock-app'
import './styles'


global css
	* box-sizing:border-box p:0 m:0
	body max-width:400px min-width:300px mx:auto mt:2
	li list-style:none

tag App
	prop sites = []
	newLead = ""

	# this is like useEffect, will be called on load
	def setup
		if window.localStorage.getItem("sites")
			sites = JSON.parse window.localStorage.getItem("sites")

	def persist
		window.localStorage.setItem("sites", JSON.stringify sites)

	def addLead
		if !newLead
			return window.alert "Can't save empty lead"
		sites.push(newLead)
		newLead = ""
		persist()

	def deleteLead i
		const ok = window.confirm "You are deleting '{sites[i]}'"
		if not ok
			return
		sites.splice(i, 1)
		persist()

	def clearInput
		newLead=""

	def saveTab
		const options = {active: true, lastFocusedWindow:true}
		chrome.tabs.query options, do(tabs)
			let activeTab = tabs[0]
			sites.push(activeTab)
		persist()


	<self [bd:cool3 px:4 pb:4 rd:lg]>
		<clock-app>
		<form @submit.prevent=addLead [mt:2]>
			<div [d:flex bd:red4 p:1 mb:2 rd:md] [bd:green4]=newLead>
				if !newLead
					<button type="button" [bgc:green3 @hover:green4 bd:none p:1 rd:sm cursor:pointer] @click=saveTab> "Save Tab"
				else 
					<button type="submit" [bgc:green3 @hover:green4 bd:none p:1 rd:sm cursor:pointer]> "Add Site"
				<input [w:100% p:2 bd:none ol:none] placeholder="Add a cool site here..." bind=newLead>
				<button type="button" [bgc:clear bd:none px:2 cursor:pointer c@hover:red4] [d:none]=!newLead @click=clearInput> "x"
		<h3 [ta:center m:2 c:cool6]> "Cool Sites"
		if !sites.length
			<p [ta:center]> "There's nothing here."
		else
			<div [d:vflex g:2 mt:2]> for lead, i in sites
				<div [d:flex jc:space-between ai:center ] key=i>
					<a href="http://{lead}" target="_blank" [c:blue6 text-decoration:none @hover:underline]> lead
					<button @click=deleteLead(i) [bgc:clear bd:none c@hover:red5 cursor:pointer]> "remove"


imba.mount do <div>
	<App>



tag clock-app
	<self autorender=1fps [pos:relative fs:sm]>
		const date = new Date()
		const seconds = date.getSeconds()
		const minutes = date.getMinutes()
		const hours = date.getHours()
		<div [d:hcr g:1]>
			<div> if hours < 10 then "0" + hours else hours
			<div [fw:bold c:cool4]> ":"
			<div> if minutes < 10 then "0" + hours  else minutes 
			<div [fw:bold c:cool4]> ":"
			<div> if seconds < 10 then "0" + seconds else seconds
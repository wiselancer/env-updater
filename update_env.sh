#!/bin/bash

# Function to display a spinner while waiting
show_spinner() {
	local pid=$1
	local delay=0.2
	local spin_chars="/-\\|"

	# Show the spinner while the process with the given PID is running
	while ps -p "$pid" >/dev/null 2>&1; do
		for i in $(seq 0 3); do
			echo -ne "\r${spin_chars:i:1} Fetching..."
			sleep $delay
		done
	done
	echo -ne "\r   \r" # Clear the spinner
}

# Inform the user that the script is starting
echo "🚀 Starting to fetch credentials from 1Password..."

# Fetch the ANTHROPIC_API_KEY
echo "🔑 Fetching ANTHROPIC_API_KEY..."
{
	ANTHROPIC_API_KEY=$(op read "op://Employee/Claude/credential") # Fetch credential
} &                                                             # Run in background
show_spinner $!                                                 # Show spinner while fetching
echo "✅ ANTHROPIC_API_KEY fetched successfully."

# Fetch the TAVILY_API_KEY with progress indication
echo "🔑 Fetching TAVILY_API_KEY..."
{
	TAVILY_API_KEY=$(op read "op://Employee/Tavily/credential") # Fetch credential
} &
show_spinner $!
echo "✅ TAVILY_API_KEY fetched successfully."

# Inform the user that the script is updating the .env file
echo "📝 Updating .env file..."

# Update the credentials in the .env file without a progress bar
{
	sed -i '' '/^ANTHROPIC_API_KEY=/d' .env
	echo "ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY" >>.env
	sed -i '' '/^TAVILY_API_KEY=/d' .env
	echo "TAVILY_API_KEY=$TAVILY_API_KEY" >>.env
}
echo "✅ Credentials added to .env."

# Inform the user that the process is complete
echo "🎉 All done! .env file has been updated successfully."

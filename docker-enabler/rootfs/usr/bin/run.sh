#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Docker Enabler
# Un-protected an add-on to gain full access to the Docker socket of Hassio.
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare response
declare result
declare status
declare target

target=$(hass.config.get 'target')

if ! hass.api.supervisor.ping; then
    hass.die "Cannot reach the HassIO API. How do you expect me to unlock?!"
fi

if ! response=$(curl --silent --show-error \
    --write-out '\n%{http_code}' --request "POST" \
    -H "X-HASSIO-KEY: ${HASSIO_TOKEN}" \
    -d '{ "protected": false }' \
    "${HASS_API_ENDPOINT}/addons/${target}/security"
); then
    hass.log.info "${response}"
    hass.log.die "Something went wrong contacting the API"
fi

status=${response##*$'\n'}
response=${response%$status}

hass.log.info "API HTTP Response code: ${status}"
hass.log.info "API Response: ${response}"

if [[ "${status}" -eq 401 ]]; then
    hass.die "Unable to authenticate with the API, permission denied"
fi

if [[ "${status}" -eq 404 ]]; then
    hass.die "Requested resource was not found"
fi

if [[ "${status}" -eq 405 ]]; then
    hass.die "Requested resource was called using an unallowed method."
fi

if [[ "${status}" -ne 200 ]]; then
    hass.die "Unknown HTTP error occured"
fi

if [[ $(hass.jq "${response}" ".result") = "error" ]]; then
    hass.die "Got unexpected response from the API:" \
        "$(hass.jq "${response}" '.message // empty')"
fi

result=$(hass.jq "${response}" 'if .data == {} then empty else .data end')

hass.log.info "${result}"

exit "${EX_OK}"

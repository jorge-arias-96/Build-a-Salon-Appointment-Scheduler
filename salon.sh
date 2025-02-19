#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo Welcome to My Salon, how can I help you?
  echo -e "\n1) cut\n2) dry\n3) tan"
  read SERVICE_ID_SELECTED

#Menu for the 3 services
  case $SERVICE_ID_SELECTED in
    1) CUT ;;
    2) DRY ;;
    3) TAN ;;
    *) MAIN_MENU "Please enter a valid option." ;;
  esac

}


CUT(){
  #Get phone number
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE
  #Check for existing users
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  #Add new user
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
  #Get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  #Get time
  echo -e "\nWhat time would you like the appointment, $CUSTOMER_NAME?"
  read SERVICE_TIME

  #Formatting the outputs for the last message
  SERVICE_TIME_FORMATTED=$(echo $SERVICE_TIME | sed -E 's/^ *| *$//g')
  CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')

  #Insert the appointment
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES('$SERVICE_TIME', $CUSTOMER_ID, $SERVICE_ID_SELECTED)")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  echo "I have put you down for a $SERVICE_NAME at $SERVICE_TIME_FORMATTED, $CUSTOMER_NAME_FORMATTED."

}

DRY(){
  #Get phone number
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE
  #Check for existing users
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  #Add new user
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
  #Get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  #Get time
  echo -e "\nWhat time would you like the appointment, $CUSTOMER_NAME?"
  read SERVICE_TIME

  #Formatting the outputs for the last message
  SERVICE_TIME_FORMATTED=$(echo $SERVICE_TIME | sed -E 's/^ *| *$//g')
  CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')

  #Insert the appointment
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES('$SERVICE_TIME', $CUSTOMER_ID, $SERVICE_ID_SELECTED)")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  echo "I have put you down for a $SERVICE_NAME at $SERVICE_TIME_FORMATTED, $CUSTOMER_NAME_FORMATTED."

}

TAN(){
  #Get phone number
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE
  #Check for existing users
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  #Add new user
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
  #Get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  #Get time
  echo -e "\nWhat time would you like the appointment, $CUSTOMER_NAME?"
  read SERVICE_TIME

  #Formatting the outputs for the last message
  SERVICE_TIME_FORMATTED=$(echo $SERVICE_TIME | sed -E 's/^ *| *$//g')
  CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')

  #Insert the appointment
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES('$SERVICE_TIME', $CUSTOMER_ID, $SERVICE_ID_SELECTED)")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  echo "I have put you down for a $SERVICE_NAME at $SERVICE_TIME_FORMATTED, $CUSTOMER_NAME_FORMATTED."
}

MAIN_MENU

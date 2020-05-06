import React, { useContext, useEffect } from 'react';
import {UserContext} from '../singlePage/singlePage';
import Logo from '../header/logo.png';
import { makeStyles } from '@material-ui/core/styles';

import * as API from '../connectionHandler/connectionHandler'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faCogs } from '@fortawesome/free-solid-svg-icons'
import { IconButton } from '@material-ui/core';

const Header = ({ onSettingsClick, onError }) => {

  const useStyles = makeStyles({
    header: {
      height: '50px',
      width: '100vw',
      top: '0px',
      backgroundColor: '#2E75B6',
    },
    logo: {
      float: 'left',
    },
    button: {
      flexBasis: '8.33%',
      float: 'right'
    },
    options: {
      float: 'right',
      paddingLeft: '10px',
      paddingRight: '5px',
      marginTop: '5px'
    },
    username: {
      color: '#FFF',
      float: 'right',
      marginTop: '12px',
      marginRight: '12px'
    },
    headerRight: {
      position: 'relative'
    }
  });

  const classes = useStyles();

  const user = useContext(UserContext);

  const settings = user? 
    (user.roles.includes("Admin") || user.roles.includes("Verkäufer"))?
    <>
      <div className={classes.username}>{user.firstName + ' ' + user.lastName}</div>
      <IconButton className={classes.button} onClick={onSettingsClick}>
        <FontAwesomeIcon icon={faCogs} />
      </IconButton>
    </>
    :
    <div className={classes.username}>{user.firstName + ' ' + user.lastName}</div>
    : null;

  return (
    <div className={classes.header}>
      <a href='/'>
        <img className={classes.logo} src={Logo} alt={'Logo uniCalc'} height={'50px'} />
      </a>
      <div className={classes.headerRight}>
        {settings}
      </div>
    </div>
  );
};

export default Header;
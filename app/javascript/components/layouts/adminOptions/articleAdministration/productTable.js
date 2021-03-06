import React, {useEffect} from 'react';
import PropTypes from 'prop-types';
import clsx from 'clsx';
import {lighten, makeStyles} from '@material-ui/core/styles';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TablePagination from '@material-ui/core/TablePagination';
import TableRow from '@material-ui/core/TableRow';
import TableSortLabel from '@material-ui/core/TableSortLabel';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import Paper from '@material-ui/core/Paper';
import {getProducts} from "../../../connectionHandler/connectionHandler";


const ProductTable = ({npks, setErrorMessage, products, setProducts}) => {

  useEffect(() => {
    getProducts(setErrorMessage, setProducts)
  }, []);

  function createData(id, title, price, unit, description) {
    return {id, title, price, unit, description};
  }

  const rows = products.map(function (item) {
        if(item.npk_id != null){
          return createData(
            (npks.find(npk => npks.find(entry => entry.id == item.npk_id).npk_id == npk.id).number + '.' + npks.find(entry => entry.id == item.npk_id).number + '.' + item.number ),
            item.name,
            Number(item.price).toFixed(2),
            item.unit,
            item.description);

        } else {
          return createData(
          item.number,
          item.name,
          Number(item.price).toFixed(2),
          item.unit,
          item.description);
        }
  });

  function descendingComparator(a, b, orderBy) {
    if (b[orderBy] < a[orderBy]) {
      return -1;
    }
    if (b[orderBy] > a[orderBy]) {
      return 1;
    }
    return 0;
  }

  function getComparator(order, orderBy) {
    return order === 'desc'
        ? (a, b) => descendingComparator(a, b, orderBy)
        : (a, b) => -descendingComparator(a, b, orderBy);
  }

  function stableSort(array, comparator) {
    const stabilizedThis = array.map((el, index) => [el, index]);
    stabilizedThis.sort((a, b) => {
      const order = comparator(a[0], b[0]);
      if (order !== 0) return order;
      return a[1] - b[1];
    });
    return stabilizedThis.map((el) => el[0]);
  }

  const headCells = [
    {id: 'id', numeric: false, disablePadding: false, label: 'Artikelnr.'},
    {id: 'title', numeric: false, disablePadding: false, label: 'Artikelbez.'},
    {id: 'price', numeric: true, disablePadding: false, label: 'Preis'},
    {id: 'unit', numeric: false, disablePadding: false, label: 'Einheit'},
    {id: 'description', numeric: false, disablePadding: false, label: 'Beschreibung'},
  ];

  function EnhancedTableHead(props) {
    const {classes, order, orderBy, onRequestSort} = props;
    const createSortHandler = (property) => (event) => {
      onRequestSort(event, property);
    };

    return (
        <TableHead>
          <TableRow>
            {headCells.map((headCell) => (
                <TableCell
                    key={headCell.id + 'tableCell'}
                    align={headCell.numeric ? 'right' : 'left'}
                    padding={headCell.disablePadding ? 'none' : 'default'}
                    sortDirection={orderBy === headCell.id ? order : false}
                >
                  <TableSortLabel
                      key={headCell.id + 'tableSortLabel'}
                      active={orderBy === headCell.id}
                      direction={orderBy === headCell.id ? order : 'asc'}
                      onClick={createSortHandler(headCell.id)}
                  >
                    {headCell.label}
                    {orderBy === headCell.id ? (
                        <span className={classes.visuallyHidden}>
                  {order === 'desc' ? 'sorted descending' : 'sorted ascending'}
                </span>
                    ) : null}
                  </TableSortLabel>
                </TableCell>
            ))}
          </TableRow>
        </TableHead>
    );
  }

  EnhancedTableHead.propTypes = {
    classes: PropTypes.object.isRequired,
    numSelected: PropTypes.number.isRequired,
    onRequestSort: PropTypes.func.isRequired,
    order: PropTypes.oneOf(['asc', 'desc']).isRequired,
    orderBy: PropTypes.string.isRequired,
    rowCount: PropTypes.number.isRequired,
  };

  const useToolbarStyles = makeStyles((theme) => ({
    root: {
      paddingLeft: theme.spacing(2),
      paddingRight: theme.spacing(1),
    },
    highlight:
        theme.palette.type === 'light'
            ? {
              color: theme.palette.secondary.main,
              backgroundColor: lighten(theme.palette.secondary.light, 0.85),
            }
            : {
              color: theme.palette.text.primary,
              backgroundColor: theme.palette.secondary.dark,
            },
    title: {
      flex: '1 1 100%',
    },
  }));

  const EnhancedTableToolbar = (props) => {
    const classes = useToolbarStyles();
    const {numSelected} = props;

    return (
        <Toolbar
            className={clsx(classes.root, {
              [classes.highlight]: numSelected > 0,
            })}
        >
          {numSelected > 0 ? (
              <Typography className={classes.title} color="inherit" variant="subtitle1" component="div">
                {numSelected} selected
              </Typography>
          ) : (
              <Typography className={classes.title} variant="h6" id="tableTitle" component="div">
                Artikelübersicht
              </Typography>
          )}
        </Toolbar>
    );
  };

  EnhancedTableToolbar.propTypes = {
    numSelected: PropTypes.number.isRequired,
  };

  const useStyles = makeStyles(() => ({
    root: {
      width: '100%',
    },
    paper: {
      width: '100%',
      marginBottom: '20px'

    },
    table: {
      minWidth: 750,
    },
    visuallyHidden: {
      border: 0,
      clip: 'rect(0 0 0 0)',
      height: 1,
      margin: -1,
      overflow: 'hidden',
      padding: 0,
      position: 'absolute',
      top: 20,
      width: 1,
    },
  }));

  const classes = useStyles();
  const [order, setOrder] = React.useState('asc');
  const [orderBy, setOrderBy] = React.useState('id');
  const [page, setPage] = React.useState(0);
  const dense = false
  const [rowsPerPage, setRowsPerPage] = React.useState(5);

  const handleRequestSort = (event, property) => {
    const isAsc = orderBy === property && order === 'asc';
    setOrder(isAsc ? 'desc' : 'asc');
    setOrderBy(property);
  };

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };

  const emptyRows = rowsPerPage - Math.min(rowsPerPage, rows.length - page * rowsPerPage);

  return (
      <div className={classes.root}>
        <Paper className={classes.paper}>
          <EnhancedTableToolbar numSelected={0}/>
          <TableContainer>
            <Table
                className={classes.table}
                aria-labelledby="tableTitle"
                size={dense ? 'small' : 'medium'}
                aria-label="enhanced table"
            >
              <EnhancedTableHead
                  classes={classes}
                  order={order}
                  orderBy={orderBy}
                  onRequestSort={handleRequestSort}
                  rowCount={rows.length}
                  numSelected={0}
              />
              <TableBody>
                {stableSort(rows, getComparator(order, orderBy))
                    .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                    .map((row, index) => {
                      const labelId = `enhanced-table-checkbox-${index}`;

                      return (
                          <TableRow
                              key={row.id + 'tableRow' + index}
                          >
                            <TableCell align="left" component="th" id={labelId} scope="row">
                              {row.id}
                            </TableCell>
                            <TableCell align="left">{row.title}</TableCell>
                            <TableCell align="right">{row.price}</TableCell>
                            <TableCell align="left">{row.unit}</TableCell>
                            <TableCell align="left">{row.description}</TableCell>
                          </TableRow>
                      );
                    })}
                {emptyRows > 0 && (
                    <TableRow style={{height: (dense ? 33 : 53) * emptyRows}}>
                      <TableCell colSpan={5}/>
                    </TableRow>
                )}
              </TableBody>
            </Table>
          </TableContainer>
          <TablePagination
              rowsPerPageOptions={[5, 10, 25]}
              component="div"
              count={rows.length}
              rowsPerPage={rowsPerPage}
              page={page}
              onChangePage={handleChangePage}
              onChangeRowsPerPage={handleChangeRowsPerPage}
          />
        </Paper>
      </div>
  );
}

export default ProductTable;
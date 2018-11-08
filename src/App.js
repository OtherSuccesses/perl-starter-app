import React, { Component } from 'react';
import './App.css';
import data from './data.js';

class App extends Component {
  constructor(){
    super();
    this.state = {
      tableData: data
    }
  }

  componentDidMount(){
    console.log(this.state.tableData);
  }

  render() {
    return (
      <div className="App">
        <h1>Name Table</h1>
        <table className="name-table">
          <tbody>
          <tr id = 'table-header'>
            <td className='labels'>First Name</td>
            <td className='labels'>Last Name</td>
            <td className='labels'>Home</td>
          </tr>
          
          {
            
            this.state.tableData.map(function(person){
              let elemId = person.first_name+person.index
              let fName = person.first_name;
              let lName = person.last_name;
              let home = person.home;

              return(
                <tr id={elemId}>
                  <td className='data-point'>
                    {fName}
                  </td>
                  <td>
                    {lName == null ? 'N/A'
                      : lName}
                  </td>
                  <td>
                    {home}
                  </td>
                </tr>)
            })
          }
          </tbody>
        </table>
      </div>
    );
  }
}

export default App;

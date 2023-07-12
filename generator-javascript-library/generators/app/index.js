const Generator = require('yeoman-generator');
const jsonfile = require('jsonfile');
const path = require('path');
const fs = require('fs');
const { spawnCommandSync } = require('yeoman-generator/lib/actions/spawn-command');

module.exports = class extends Generator {
  prompting() {
    return this.prompt([
      {
        type: 'input',
        name: 'jsonPath',
        message: 'Por favor, introduce la ruta del archivo JSON:'
      },
      {
        type: 'input',
        name: 'projectName',
        message: 'Por favor, introduce el nombre de tu proyecto React:'
      }
    ]).then((answers) => {
      const jsonPath = answers.jsonPath;
      const projectName = answers.projectName;

      // Ejecuta el comando "npx create-react-app" para crear el proyecto React
      this.log('Generando el proyecto React...');
      const result = spawnCommandSync('npx', ['create-react-app', projectName]);

      if (result.status !== 0) {
        this.log.error('Error al generar el proyecto React.');
        return;
      }

      this.log('El proyecto React se ha generado correctamente.');

      // Mueve el archivo JSON al directorio src del proyecto
      const sourceJsonPath = path.resolve(jsonPath);
      const destinationJsonPath = this.destinationPath(projectName, 'src', 'catalogo.json');
      fs.copyFileSync(sourceJsonPath, destinationJsonPath);
      this.log('El archivo JSON se ha movido al directorio src del proyecto.');

      // Cambia al directorio del proyecto React recién creado
      const projectPath = this.destinationPath(projectName);
      this.destinationRoot(projectPath);

      // Lee el archivo JSON
      const jsonPath2 = path.join(answers.jsonPath);
      jsonfile.readFile(path.join(jsonPath2), (err, data) => {
        if (err) {
          this.log.error('Error al leer el archivo JSON:', err);
          return;
        }

        // Verifica si el JSON contiene la clave "Explorador"
        if (data.hasOwnProperty('Explorador')) {

          // Crea la carpeta "src" si no existe
          const jsFolderPath = this.destinationPath('src');
          if (!fs.existsSync(jsFolderPath)) {
            fs.mkdirSync(jsFolderPath);
          }

          // Sobrescribe el archivo App.js con el nuevo código
          const appFilePath = this.destinationPath('src', 'App.js');
          const newAppCode = `
        
          import React from 'react';
          import Explorador from './Explorador';
          import filters from './catalogo.json';
  
          const App = () => {
            return (
              <div>
                <Explorador data={filters} />
              </div>
            );
          };
  
          export default App;
        
      `;

          fs.writeFileSync(appFilePath, newAppCode);
          this.log('Se ha sobrescrito el archivo App.js con el nuevo código.');

          // Crea el archivo JavaScript en la carpeta "src" con el código para la barra de búsqueda web
          const jsFilePath = this.destinationPath('src/Explorador.js');
          const jsCode = `
          
          import React, { useState, useEffect } from 'react';
          import { Biblioteca } from './Biblioteca';

          const Explorador = ({ data }) => {
            const exploradorData = data.Explorador;
            const filtroItem = exploradorData.FiltroItem;
            const filtroColecccion = exploradorData.FiltroColecccion;
            const filtroSColeccion = exploradorData.FiltroSColeccion;
          
            const [selectedOption, setSelectedOption] = useState("");
            const [subOptions, setSubOptions] = useState([]);
            const [subSubOptions, setSubSubOptions] = useState([]);
          
            // Implementa el componente de la barra de búsqueda de la página web aquí
            const handleSearch = (event) => {
              // Lógica para buscar utilizando los filtros del JSON
              // ...
            };
          
            // Maneja el cambio de opción principal seleccionada
            const handleOptionChange = (event) => {
              const selectedOption = event.target.value;
              setSelectedOption(selectedOption);
          
              // Obtiene la lista de subopciones correspondiente a la opción seleccionada
              let subOptions = [];
          
              if (selectedOption === "FiltroItem") {
                subOptions = Object.keys(filtroItem);
              } else if (selectedOption === "FiltroColecccion") {
                subOptions = Object.keys(filtroColecccion);
              } else if (selectedOption === "FiltroSColeccion") {
                subOptions = Object.keys(filtroSColeccion);
              }
          
              setSubOptions(subOptions);
              setSubSubOptions([]); // Reinicia las sub-subopciones al cambiar la opción principal
            };
          
            // Maneja el cambio de subopción seleccionada
            const handleSubOptionChange = (event) => {
              const selectedSubOption = event.target.value;
              setSelectedOption(selectedSubOption);
            };
          
            // Actualiza las sub-subopciones cuando se selecciona una subopción
            useEffect(() => {
              let subSubOptions = [];
              
              if (selectedOption === "Autor") {
                subSubOptions = Object.keys(filtroItem.Autor).reduce((acc, autor) => {
                  if (filtroItem.Autor[autor].length > 0) {
                    acc.push(autor);
                  }
                  return acc;
                }, []);
              } else if (selectedOption === "Fecha") {
                subSubOptions = Object.keys(filtroColecccion.Fecha);
              }else if (selectedOption === "Genero") {
              subSubOptions = Object.keys(filtroSColeccion.Genero);
            }
          
              setSubSubOptions(subSubOptions);
            }, [selectedOption]);
          
            return (
              <div>
                <h1>Barra de Búsqueda Web</h1>
                {/* Lista desplegable para los filtros de "Item" */}
                <select value={selectedOption} onChange={handleOptionChange}>
                  <option value="">Seleccione un filtro</option>
                  <option value="FiltroItem">FiltroItem</option>
                  <option value="FiltroColecccion">FiltroColecccion</option>
                  <option value="FiltroSColeccion">FiltroSColeccion</option>
                </select>
          
                {/* Lista desplegable para las subopciones */}
                {selectedOption && (
                  <select value={subSubOptions} onChange={handleSubOptionChange}>
                    <option value="">Seleccione una subopción</option>
                    {subOptions.map((subOption) => (
                      <option key={subOption} value={subOption}>
                        {subOption}
                      </option>
                    ))}
                  </select>
                )}
          
                {/* Lista desplegable para las sub-subopciones */}
                {subSubOptions.length > 0 && (
                  <select>
                    <option value="">Seleccione una sub-subopción</option>
                    {subSubOptions.map((option) => (
                      <option key={option} value={option}>
                        {option}
                      </option>
                    ))}
                  </select>
                )}
          
                <input type="text" onChange={handleSearch} />
                <Biblioteca data={data} />
              </div>
            );
          };
          
          export default Explorador;
          
          
          
          `;

          fs.writeFileSync(jsFilePath, jsCode);
          this.log('El archivo JavaScript de la barra de búsqueda web se ha creado correctamente.');

          // Crea el archivo JavaScript en la carpeta "src" con el código para la barra de búsqueda web
          const jsFilePathBiblioteca = this.destinationPath('src/Biblioteca.js');
          const jsCodeBiblioteca = `
          import React from 'react';

          export const Biblioteca = ({ data }) => {
            const items = data.componentes.items;
            const colecciones = data.componentes.colecciones;
            const supercolecciones = data.componentes.supercolecciones;

            return (
              <div>
                <h1>Biblioteca</h1>

                {/* Mostrar elementos de la categoría "items" */}
                <h2>Items</h2>
                {Object.entries(items).map(([itemId, itemData]) => (
                  <div key={itemId}>
                    <h3>{itemId}</h3>
                    <ul>
                      {itemData.array.map((item, index) => (
                        <li key={index}>{item.tipo}: {item.value}</li>
                      ))}
                    </ul>
                  </div>
                ))}

                {/* Mostrar elementos de la categoría "colecciones" */}
                <h2>Colecciones</h2>
                {Object.entries(colecciones).map(([coleccionId, coleccionData]) => (
                  <div key={coleccionId}>
                    <h3>{coleccionId}</h3>
                    <ul>
                      {coleccionData.map((item, index) => (
                        <li key={index}>
                          {Object.entries(item).map(([prop, value]) => (
                            <span key={prop}>
                              {prop}: {Array.isArray(value) ? value.join(', ') : value}
                            </span>
                          ))}
                        </li>
                      ))}
                    </ul>
                  </div>
                ))}

                {/* Mostrar elementos de la categoría "supercolecciones" */}
                <h2>Supercolecciones</h2>
                {Object.entries(supercolecciones).map(([supercoleccionId, supercoleccionData]) => (
                  <div key={supercoleccionId}>
                    <h3>{supercoleccionId}</h3>
                    <ul>
                      {supercoleccionData.map((item, index) => (
                        <li key={index}>
                          {Object.entries(item).map(([prop, value]) => (
                            <span key={prop}>
                              {prop}: {Array.isArray(value) ? value.join(', ') : value}
                            </span>
                          ))}
                        </li>
                      ))}
                    </ul>
                  </div>
                ))}
              </div>
            );
          };

          `;

          fs.writeFileSync(jsFilePathBiblioteca, jsCodeBiblioteca);
          this.log('El archivo JavaScript de labiblioteca web se ha creado correctamente.');


        } else {
          this.log('El JSON no contiene la clave "Explorador".');
        }
      });
    });
  }
};

﻿using Core.Erp.Data.General;
using Core.Erp.Info.CuentasPorPagar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Core.Erp.Data.CuentasPorPagar
{
    public class cp_proveedor_Data
    {
        public List<cp_proveedor_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<cp_proveedor_Info> Lista;
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.vwcp_proveedor_consulta
                                 join t in Context.cp_proveedor_clase
                                 on new { q.IdEmpresa, q.IdClaseProveedor } equals new { t.IdEmpresa, t.IdClaseProveedor }
                                 where q.IdEmpresa == IdEmpresa
                                 select new cp_proveedor_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdProveedor = q.IdProveedor,
                                     pr_estado = q.pr_estado,
                                     descripcion_clas_prove = t.descripcion_clas_prove,
                                     IdEntidad=q.IdProveedor,
                                     info_persona = new Info.General.tb_persona_Info
                                     {
                                         IdPersona = q.IdPersona,
                                         pe_nombreCompleto = q.pe_nombreCompleto,
                                         pe_cedulaRuc = q.pe_cedulaRuc
                                     }
                                 }).ToList();
                    else
                        Lista = (from q in Context.vwcp_proveedor_consulta
                                 join t in Context.cp_proveedor_clase
                                 on new { q.IdEmpresa, q.IdClaseProveedor } equals new { t.IdEmpresa, t.IdClaseProveedor }
                                 where q.IdEmpresa == IdEmpresa
                                 && q.pr_estado == "A"
                                 select new cp_proveedor_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdProveedor = q.IdProveedor,
                                     pr_estado = q.pr_estado,
                                     descripcion_clas_prove = t.descripcion_clas_prove,
                                     info_persona = new Info.General.tb_persona_Info
                                     {
                                         IdPersona = q.IdPersona,
                                         pe_nombreCompleto = q.pe_nombreCompleto,
                                         pe_cedulaRuc = q.pe_cedulaRuc
                                     }
                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        } 

        public cp_proveedor_Info get_info(int IdEmpresa, decimal IdProveedor)
        {
            try
            {
                cp_proveedor_Info info = new cp_proveedor_Info();
                Entities_cuentas_por_pagar Context_p = new Entities_cuentas_por_pagar();
                Entities_general Context_g = new Entities_general();

                cp_proveedor Entity = Context_p.cp_proveedor.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdProveedor == IdProveedor);
                    if (Entity == null) return null;
                    info = new cp_proveedor_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdProveedor = Entity.IdProveedor,
                        IdPersona = Entity.IdPersona,
                        IdClaseProveedor = Entity.IdClaseProveedor,
                        IdCiudad = Entity.IdCiudad,
                        idCredito_Predeter = Entity.idCredito_Predeter,
                        IdBanco_acreditacion = Entity.IdBanco_acreditacion,
                        IdCentroCosot = Entity.IdCentroCosot,
                        IdCtaCble_Anticipo = Entity.IdCtaCble_Anticipo,
                        IdCtaCble_CXP = Entity.IdCtaCble_CXP,
                        IdCtaCble_Gasto = Entity.IdCtaCble_Gasto,
                        IdPunto_cargo = Entity.IdPunto_cargo,
                        IdPunto_cargo_grupo = Entity.IdPunto_cargo_grupo,
                        IdTipoCta_acreditacion_cat = Entity.IdTipoCta_acreditacion_cat,
                        codigoSRI_101_Predeter = Entity.codigoSRI_101_Predeter,
                        codigoSRI_ICE_Predeter = Entity.codigoSRI_ICE_Predeter,
                        pr_contribuyenteEspecial_bool = Entity.pr_contribuyenteEspecial == "S" ? true : false,
                        es_empresa_relacionada = Entity.es_empresa_relacionada,
                        num_cta_acreditacion = Entity.num_cta_acreditacion,
                        pr_codigo = Entity.pr_codigo,
                        pr_plazo = Entity.pr_plazo,
                        representante_legal = Entity.representante_legal,
                        pr_estado = Entity.pr_estado,
                        pr_correo = Entity.pr_correo,
                        pr_direccion = Entity.pr_direccion,
                        pr_telefonos = Entity.pr_telefonos,
                        pr_celular = Entity.pr_celular
                    };
                tb_persona Entity_p = Context_g.tb_persona.Where(q => q.IdPersona == info.IdPersona).FirstOrDefault();
                info.info_persona = new Info.General.tb_persona_Info
                {
                    IdPersona = Entity_p.IdPersona,
                    pe_apellido = Entity_p.pe_apellido,
                    pe_nombre = Entity_p.pe_nombre,
                    pe_cedulaRuc = Entity_p.pe_cedulaRuc,
                    pe_nombreCompleto = Entity_p.pe_nombreCompleto,
                    pe_razonSocial = Entity_p.pe_razonSocial,
                    pe_Naturaleza = Entity_p.pe_Naturaleza,
                    IdTipoDocumento = Entity_p.IdTipoDocumento
                };

                Context_p.Dispose();
                Context_g.Dispose();
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private decimal get_id(int IdEmpresa)
        {
            try
            {
                decimal ID = 1;
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    var lst = from q in Context.cp_proveedor
                              where q.IdEmpresa == IdEmpresa
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdProveedor) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(cp_proveedor_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar() )
                {
                    cp_proveedor Entity = new cp_proveedor
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdProveedor = info.IdProveedor=get_id(info.IdEmpresa),
                        IdPersona = info.IdPersona,
                        IdClaseProveedor = info.IdClaseProveedor,
                        IdCiudad = info.IdCiudad,
                        idCredito_Predeter = info.idCredito_Predeter,
                        IdBanco_acreditacion = info.IdBanco_acreditacion,
                        IdCentroCosot = info.IdCentroCosot,
                        IdCtaCble_Anticipo = info.IdCtaCble_Anticipo,
                        IdCtaCble_CXP = info.IdCtaCble_CXP,
                        IdCtaCble_Gasto = info.IdCtaCble_Gasto,
                        IdPunto_cargo = info.IdPunto_cargo,
                        IdPunto_cargo_grupo = info.IdPunto_cargo_grupo,
                        IdTipoCta_acreditacion_cat = info.IdTipoCta_acreditacion_cat,
                        codigoSRI_101_Predeter = info.codigoSRI_101_Predeter,
                        codigoSRI_ICE_Predeter = info.codigoSRI_ICE_Predeter,
                        num_cta_acreditacion = info.num_cta_acreditacion,
                        pr_codigo = info.pr_codigo,
                        pr_plazo = info.pr_plazo,
                        representante_legal = info.representante_legal,
                        pr_estado = info.pr_estado="A",
                        pr_contribuyenteEspecial = info.pr_contribuyenteEspecial_bool == true ? "S" : "N",
                        es_empresa_relacionada = info.es_empresa_relacionada,
                        pr_celular = info.pr_celular,
                        pr_telefonos = info.pr_telefonos,
                        pr_direccion = info.pr_direccion,
                        pr_correo = info.pr_correo,
                        

                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now
                    };
                    Context.cp_proveedor.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(cp_proveedor_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_proveedor Entity = Context.cp_proveedor.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdProveedor == info.IdProveedor);
                    if (Entity == null) return false;

                    Entity.IdPersona = info.IdPersona;
                    Entity.IdClaseProveedor = info.IdClaseProveedor;
                    Entity.IdCiudad = info.IdCiudad;
                    Entity.idCredito_Predeter = info.idCredito_Predeter;
                    Entity.IdBanco_acreditacion = info.IdBanco_acreditacion;
                    Entity.IdCentroCosot = info.IdCentroCosot;
                    Entity.IdCtaCble_Anticipo = info.IdCtaCble_Anticipo;
                    Entity.IdCtaCble_CXP = info.IdCtaCble_CXP;
                    Entity.IdCtaCble_Gasto = info.IdCtaCble_Gasto;
                    Entity.IdPunto_cargo = info.IdPunto_cargo;
                    Entity.IdPunto_cargo_grupo = info.IdPunto_cargo_grupo;
                    Entity.IdTipoCta_acreditacion_cat = info.IdTipoCta_acreditacion_cat;
                    Entity.codigoSRI_101_Predeter = info.codigoSRI_101_Predeter;
                    Entity.codigoSRI_ICE_Predeter = info.codigoSRI_ICE_Predeter;
                    Entity.num_cta_acreditacion = info.num_cta_acreditacion;
                    Entity.pr_codigo = info.pr_codigo;
                    Entity.pr_plazo = info.pr_plazo;
                    Entity.pr_contribuyenteEspecial = info.pr_contribuyenteEspecial_bool == true ? "S" : "N";
                    Entity.es_empresa_relacionada = info.es_empresa_relacionada;
                    Entity.pr_correo = info.pr_correo;
                    Entity.pr_direccion = info.pr_direccion;
                    Entity.pr_telefonos = info.pr_telefonos;
                    Entity.pr_celular = info.pr_celular;

                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(cp_proveedor_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_proveedor Entity = Context.cp_proveedor.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdProveedor == info.IdProveedor);
                    if (Entity == null) return false;

                    Entity.pr_estado = info.pr_estado="I";

                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = DateTime.Now;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public cp_proveedor_Info get_info_x_num_cedula(int IdEmpresa, string pe_cedulaRuc)
        {
            try
            {
                cp_proveedor_Info info = new cp_proveedor_Info
                {
                    info_persona = new Info.General.tb_persona_Info()
                };

                Entities_general Context_general = new Entities_general();
                tb_persona Entity_p = Context_general.tb_persona.Where(q => q.pe_cedulaRuc == pe_cedulaRuc).FirstOrDefault();
                if (Entity_p == null)
                {
                    Context_general.Dispose();
                    return info;
                }
                Entities_cuentas_por_pagar Context_cxp = new Entities_cuentas_por_pagar();
                cp_proveedor Entity_c = Context_cxp.cp_proveedor.Where(q => q.IdEmpresa == IdEmpresa && q.IdPersona == Entity_p.IdPersona).FirstOrDefault();
                if (Entity_c == null)
                {
                    info.IdPersona = Entity_p.IdPersona;
                    info.info_persona = new Info.General.tb_persona_Info
                    {
                        IdPersona = Entity_p.IdPersona,
                        pe_apellido = Entity_p.pe_apellido,
                        pe_nombre = Entity_p.pe_nombre,
                        pe_cedulaRuc = Entity_p.pe_cedulaRuc,
                        pe_nombreCompleto = Entity_p.pe_nombreCompleto,
                        pe_razonSocial = Entity_p.pe_razonSocial,
                        pe_celular = Entity_p.pe_celular,
                        pe_telfono_Contacto = Entity_p.pe_telfono_Contacto,
                        pe_correo = Entity_p.pe_correo,
                        pe_direccion = Entity_p.pe_direccion
                    };
                    Context_general.Dispose();
                    Context_cxp.Dispose();
                    return info;
                }
                info = new cp_proveedor_Info
                {
                    IdEmpresa = Entity_c.IdEmpresa,
                    IdProveedor = Entity_c.IdProveedor,
                    IdPersona = Entity_p.IdPersona,
                    info_persona = new Info.General.tb_persona_Info
                    {
                        IdPersona = Entity_p.IdPersona,
                        pe_apellido = Entity_p.pe_apellido,
                        pe_nombre = Entity_p.pe_nombre,
                        pe_cedulaRuc = Entity_p.pe_cedulaRuc,
                        pe_nombreCompleto = Entity_p.pe_nombreCompleto,
                        pe_razonSocial = Entity_p.pe_razonSocial,
                        pe_celular = Entity_p.pe_celular,
                        pe_telfono_Contacto = Entity_p.pe_telfono_Contacto,
                        pe_correo = Entity_p.pe_correo,
                        pe_direccion = Entity_p.pe_direccion
                    }
                };

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        #region metodo bajo demanda
        public List<cp_proveedor_Info> get_list(int IdEmpresa, int skip, int take, string filter)
        {
            try
            {
                List<cp_proveedor_Info> Lista = new List<cp_proveedor_Info>();

                Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar();

                var lst = (from
                          p in Context.vwcp_proveedor_consulta
                          
                           where
                            p.IdEmpresa == IdEmpresa
                         
                           select new
                           {
                               p.IdEmpresa,
                               p.IdPersona,
                               p.IdProveedor,
                               p.pe_nombreCompleto,
                               p.pr_codigo,
                               p.pe_cedulaRuc
                           })
                             .OrderBy(p => p.IdProveedor)
                             .Skip(skip)
                             .Take(take)
                             .ToList();


                foreach (var q in lst)
                {
                    Lista.Add(new cp_proveedor_Info
                    {
                        IdEmpresa = q.IdEmpresa,
                        IdPersona = q.IdPersona,
                        //pr_descripcion = q.pr_descripcion,
                        //pr_descripcion_2 = q.pr_descripcion_2,
                        //pr_codigo = q.pr_codigo,
                        //lote_num_lote = q.lote_num_lote,
                        //lote_fecha_vcto = q.lote_fecha_vcto,
                        //nom_categoria = q.ca_Categoria,
                        //nom_presentacion = q.nom_presentacion
                    });
                }

                Context.Dispose();
              //  Lista = get_list_nombre_combo(Lista);
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        #endregion
    }
}
